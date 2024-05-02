# Use an official Python runtime as a parent image
FROM python:3.12

LABEL maintainer="zainbabar"
# Set the working directory in the container
WORKDIR /workspace
# Install system dependencies required for potential Python packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# RUN poetry config virtualenvs.create false
RUN poetry config virtualenvs.create false

# Copy the current directory contents into the container
COPY . ./

# RUN poetry install
RUN poetry install --no-interaction --no-root

ENV PYTHONPATH="/workspace:${PYTHONPATH}"
# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run the app. CMD can be overridden when starting the container
CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
