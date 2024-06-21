FROM python:3.11-slim

WORKDIR /app

# Copy and install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# Set environment variables
ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION ${AWS_DEFAULT_REGION}
ENV AWS_KINESIS_STREAM_NAME ${AWS_KINESIS_STREAM_NAME}

# Copy the app folder into the container at /app
COPY app /app

# Run the application
CMD ["python", "main.py"]
