FROM python:3.9-slim

# Crear carpeta de trabajo e instalar dependencias
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el contenido de la aplicación
COPY service/ ./service/

# Cambiar a un usuario no root por seguridad
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Ejecutar el servicio usando gunicorn
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]