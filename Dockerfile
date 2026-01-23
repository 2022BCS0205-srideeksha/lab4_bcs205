# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first (IMPORTANT)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY output/model.pkl ./model.pkl

# Expose port
EXPOSE 8000

# Start FastAPI app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
