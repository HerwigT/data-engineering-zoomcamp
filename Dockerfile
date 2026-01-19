FROM python:3.13.11-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"

COPY pyproject.toml .python-version uv.lock ./
RUN uv sync --locked

COPY /01-docker-terraform/homework/ingest_data.py .

COPY /01-docker-terraform/homework/green_tripdata_2025-11.parquet .

ENTRYPOINT ["python", "ingest_data.py"]