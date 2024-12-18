# Stage 1: Build Stage
FROM python:3.11-slim AS build

WORKDIR /app

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

# Stage 2: Production Stage
FROM python:3.11-alpine

WORKDIR /app
COPY --from=build /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY --from=build /app /app
EXPOSE 5000

CMD ["python", "app.py"]
