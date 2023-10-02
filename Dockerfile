# Use an official Python runtime as a parent image
FROM ubuntu:18.04

# Install necessary tools
RUN apt-get update && apt-get install -y wget bzip2 && apt-get clean

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/miniconda && \
    rm ~/miniconda.sh

# Add conda to PATH
ENV PATH="/root/miniconda/bin:${PATH}"

#FROM continuumio/miniconda3:4.9.2

ENV FLASK_DEBUG=1
# Set the working directory in the Docker image to /app
WORKDIR /app


#RUN apt-get update --allow-releaseinfo-change && apt-get install -y libtinfo5 && rm -rf /var/lib/apt/lists/*


# Add the current directory contents (i.e., your Python application) into the Docker image at location /app
ADD . /app

# Create and activate a Conda environment
RUN conda create --name myenv python=3.10.9
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Update pip and install any necessary dependencies specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install torch-scatter -f https://data.pyg.org/whl/torch-2.0.0+cpu.html
RUN pip install torch-sparse -f https://data.pyg.org/whl/torch-2.0.0+cpu.html
#torch-scatter==2.1.1
#torch-sparse==0.6.17


# Confirm the environment is activated
RUN echo "Make sure conda env is activated:" && printenv | grep -e CONDA -e PATH

# Make port 5000 available to the world outside this container
EXPOSE 8081

# Run the command to start the Flask app
#ENTRYPOINT ["conda", "run", "-n", "myenv", "python3", "api.py"]
ENTRYPOINT ["conda", "run", "-n", "myenv", "flask", "--app", "api", "run", "--host=0.0.0.0", "-p", "8081"]