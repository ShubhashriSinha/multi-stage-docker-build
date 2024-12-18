# Stage 1: Build Stage
FROM python:3.11-slim AS build

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Production Stage
FROM python:3.11-alpine

WORKDIR /app
COPY --from=build /app /app
EXPOSE 80

CMD ["python", "app.py"]
