FROM python:3.11-slim

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем и устанавливаем Python зависимости
COPY app/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Копируем код приложения
COPY app/ ./

# Создаем непривилегированного пользователя для безопасности
RUN useradd --create-home --shell /bin/bash appuser && \
    chown -R appuser:appuser /app
USER appuser

# Открываем порт
EXPOSE 8080

# Переменные окружения
ENV APP_VERSION=v1.0.0
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

# Health check для Kubernetes
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Запуск приложения
# Если ваш файл называется app.py, то модуль будет просто app:app
CMD ["gunicorn", "-b", "0.0.0.0:8080", "--workers", "2", "app:app"]
