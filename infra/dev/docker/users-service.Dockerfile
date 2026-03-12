FROM python:3.11-slim

WORKDIR /app

# Install the grpc runtime
RUN pip install grpcio

# Copy the script
COPY services/users-service/main.py .

EXPOSE 8083

# Run the script directly
CMD ["python", "-u", "main.py"]