import random
import numpy as np
import networkx as nx
import itertools
from queue import PriorityQueue


class HeftScheduler():
    """"
    Implementation of a task scheduler based on the HEFT heuristic

    Attributes
    ----------
        task_graph: networkx graph
                The DAG of the tasks
        task_statistics : dict
                Execution times for each task on each device
        average_task_statistics: dict
                Average execution times of all tasks across all devices
        task_power_statistics: dict
                Power consumption for each task on each device
        transfer_times: dict
                Transfer times of all pairs of tasks between all devices
        available_devices : list
                List with the unique id of each available device
        topological_order: list
                Topological order of tasks in the task graph
        est : dict
                Earliest start times for each task
        eft : dict
                Earliest finish times for each task
        ast : dict
                Actual start times for each task
        aft : dict
                Actual finish times for each task
        avail: list
                Finish time of last scheduled task for each device
    """

    def __init__(self, G, task_statistics, average_task_statistics, task_power_statistics, transfer_times, average_transfer_times, available_devices):
        self.task_graph = G
        self.task_statistics = task_statistics
        self.average_task_statistics = average_task_statistics
        self.task_power_statistics = task_power_statistics
        self.transfer_times = transfer_times
        self.average_transfer_times = average_transfer_times
        self.available_devices = available_devices
        self.topological_order = list(nx.topological_sort(self.task_graph))
        self.est = {}
        self.eft = {}
        self.aft = {}
        self.ast = {}
        self.avail = [0] * len(available_devices)

    def upward_rank(self):
        """
        Calculate upward rank for each task

        Returns
        -------
        upward_rank: dict
                Upward rank value for each task
        """
        upward_rank = {}
        upward_rank["n_exit"] = self.average_task_statistics["n_exit"]

        # Traverse the topologocal sort in inverse order to compute upward rank of nodes
        for i in range(len(self.topological_order) - 2, -1, -1):
            # Traverse from last node excluding "n_exit" to "n_entry"
            node = self.topological_order[i]
            successors = list(self.task_graph.successors(node))
            successor_ranks = np.array([upward_rank[succ_node] for succ_node in successors])
            transfer_time_with_successors = np.array([self.average_transfer_times[(node, succ_node)] for succ_node in successors])
            combined = successor_ranks + transfer_time_with_successors
            best = np.max(combined)
            rank = self.average_task_statistics[node] + best

            upward_rank[node] = rank

        return upward_rank

    def prioritize_tasks(self, rank):
        """
        Create task priority
        Contains tuples of (-rank of task, task) because we want decreasing order
        task is a string

        Attributes
        ----------
        rank: dict
                Upward rank of tasks

        Returns
        -------
        unscheduled_tasks: queue.PriorityQueue
                Priority queue of the tasks in nonincreasing order of upward rank
        """
        unscheduled_tasks = PriorityQueue()

        for task in self.topological_order:
            if task == "n_entry":
                unscheduled_tasks.put((-rank[task], "-" + task)) # we want n_entry to be before the first task with the same rank
            else:
                unscheduled_tasks.put((-rank[task], str(task)))
        return unscheduled_tasks

    def compute_est(self, task, device, scheduled_tasks):
        """
        Compute earliest start time of task on the device and add it to
        the dictinoary of earliset start times using non-insertion based policy

        Attributes
        ----------
        task: int or str
                The task to be scheduled
        device: int
                Id of the device that we want to calculate the est of the task
        scheduled_tasks: dict
                The already scheduled tasks

        Returns
        -------
        time: real
                Est of the task on the device
        """
        if task == "n_entry":
            self.est[(task, device)] = 0

            return 0
        else:
            device_avail_time = self.avail[device]
            pred_tasks = list(self.task_graph.predecessors(task))
            max_ready_time = -1
            # Compute max ready time
            for pred in pred_tasks:
                # Device that the pred tasks has already been assigned
                pred_device = scheduled_tasks[pred]
                # We know where pred tasks have been scheduled so we use the actual communication sosts
                ready_time = self.aft[pred] + self.transfer_times[(pred, task)][(pred_device, device)]
                if ready_time > max_ready_time:
                    max_ready_time = ready_time

            time = max(device_avail_time, max_ready_time)
            self.est[(task, device)] = time

            return time

    def compute_eft(self, task, device, scheduled_tasks):
        """
        Compute earliest finish time of task on the device and
        add it to the dictinoary of earliset finish times

        Attributes
        ----------
        task: int or str
                The task to be scheduled
        device: int
                Id of the device that we want to calculate the est of the task
        scheduled_tasks: dict
                The already scheduled tasks

        Returns
        -------
        time: real
                Eft of the task on the device
        """
        time = self.compute_est(task, device, scheduled_tasks) + self.task_statistics[task][device]
        self.eft[(task, device)] = time

        return time

    def compute_power_consumption(self, task_id, device_id):
        """
        Compute power consumption of task_id on device_id
        """
        if task_id == "n_entry" or task_id == "n_exit":
            return 0
        else:
            return self.task_power_statistics[task_id][device_id]

    def schedule(self, weights):
        """
        Assigns tasks to devices according to the HEFT heuristic

        Attributes
        ----------
        weights: tuple
                How much to weigh each objective (time_weight, power_weight)

        Returns
        -------
        scheduled_tasks: dict
                The device placement of each task
        """
        scheduled_tasks = {}
        rank = self.upward_rank()
        unscheduled_tasks = self.prioritize_tasks(rank)

        while not unscheduled_tasks.empty():
            # task_to_schedule = (- rank of task, task id)
            task_to_schedule = unscheduled_tasks.get()
            if task_to_schedule[1] == "-n_entry":
                task_id = "n_entry"
            elif task_to_schedule[1] == "n_exit":
                task_id = "n_exit"
            else:
                task_id = int(task_to_schedule[1])

            rank_of_task = - task_to_schedule[0]

            # Compute the combined_objective of the task in each device
            min_combined_objective = 99999999999999999
            efts = np.zeros(len(self.available_devices))
            powers = np.zeros(len(self.available_devices))
            for device_id in self.available_devices:
                temp_eft = self.compute_eft(task_id, device_id, scheduled_tasks)
                temp_power_consumption = self.compute_power_consumption(task_id, device_id)
                efts[device_id] = temp_eft
                powers[device_id] = temp_power_consumption

            # Eft and power consumption attributes are in
            # different scales so they need to be standardized in
            # order to have an accurate combined objective
            eft_min = np.min(efts)
            eft_max = np.max(efts)
            power_min = np.min(powers)
            power_max = np.max(powers)

            standardized_efts = (efts - eft_min) / (eft_max - eft_min)
            standardized_powers = (powers - power_min) / (power_max - power_min)
            combined_objectives = weights[0] * standardized_efts + weights[1] * standardized_powers

            # Select the device that minimizes the combined objective
            min_device = np.argmin(combined_objectives)
            scheduled_tasks[task_id] = min_device
            self.avail[min_device] = efts[min_device]
            self.aft[task_id] = efts[min_device]
            self.ast[task_id] = efts[min_device] - self.task_statistics[task_id][min_device]

        return scheduled_tasks


    def compute_scheduling_time_execution(self, scheduling):
        """
        Computes the execution time of a given scheduling
        (upward rank execution order)

        Attributes
        ----------
        scheduling: dict
                The device placement of each task

        Returns
        -------
        total_execution_time: real
                Execution time of the scheduling
        """
        avail = [0] * len(scheduling) # list with the time that each device is available
        aft = {}
        aft["n_entry"] = 0

        # Traverse tasks with upward rank order
        priority_of_tasks = list(scheduling.keys())

        for task in priority_of_tasks[1:]: # exclude "n_entry"
            device = scheduling[task]
            device_avail_time = avail[device]
            pred_tasks = list(self.task_graph.predecessors(task))
            max_ready_time = -1
            # Compute max ready time
            for pred in pred_tasks:
                pred_device = scheduling[pred]
                # use the actual transfer times
                ready_time = aft[pred] + self.transfer_times[(pred, task)][(pred_device, device)]
                if ready_time > max_ready_time:
                    max_ready_time = ready_time

            # Compute finish time of task and update values
            start_time = max(device_avail_time, max_ready_time)
            finish_time = start_time + self.task_statistics[task][device]
            aft[task] = finish_time
            avail[device] = finish_time

        total_execution_time = aft["n_exit"]

        return total_execution_time
