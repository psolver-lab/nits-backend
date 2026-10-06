# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app/backend

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirments.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirments.txt

# Copy the backend directory
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DEBUG=False

# Expose port
EXPOSE 8000

# Run migrations during build
RUN python manage.py migrate || true
RUN python manage.py collectstatic --noinput || true

# Start gunicorn - use sh -c to enable environment variable expansion
CMD sh -c "gunicorn core.wsgi:application --bind 0.0.0.0:${PORT:-8000} --workers 2"

