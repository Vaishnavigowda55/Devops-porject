# Stage 1: Build stage
FROM python:3.9-slim as builder

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final stage (smaller image)
FROM python:3.9-slim

WORKDIR /app
COPY --from=builder /app /app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]
