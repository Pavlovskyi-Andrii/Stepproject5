FROM python:3.11-slim

WORKDIR /app

# Копируем requirements.txt внутрь контейнера
COPY app/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Копируем саму апку
COPY app/ ./app

# Открываем порт
EXPOSE 8080

# Запускаем gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app.app:app"]