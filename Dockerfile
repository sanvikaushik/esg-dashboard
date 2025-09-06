# Use Python 3.11 slim image
FROM python:3.11-slim

WORKDIR /app

# Copy dependencies first for caching
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Set environment variables
ENV ESG_DB_PATH=/app/data/esg.db
ENV CHROMA_DIR=/app/data/chroma

# Expose ports for API and Streamlit
EXPOSE 8000 8501

# Start both API and UI (simple dev setup)
CMD bash -c "uvicorn api.server:app --host 0.0.0.0 --port 8000 & streamlit run app/main.py --server.port 8501 --server.address 0.0.0.0"
