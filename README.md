# Code Challenge: Aplicación de Mantenimiento de Autos

Aplicación desarrollada en Ruby on Rails para el manejo de Autos (Car) y sus servicios de mantenimiento (MaintenanceService). La aplicación tiene dos interfaces: Web y API. Más adelante se muestran ejemplos de API calls. La aplicación incluye filtrado de servicios de mantenimiento por el número de placa del auto o por su estado.

## Tabla de contenido

- [Pre Requisitos](#prerequisitos)
- [Instalación](#instalación)
- [Setup](#setup)
- [Ejecución de aplicación](#ejecución-de-aplicación)
- [Correr Tests](#correr-tests)
- [API Calls](#api-calls)

## Prerequisitos
Antes de instalar el app asegúrate de tener instalado lo siguiente:
- **Ruby**: Versión 3.3.5
- **Rails**: Versión 7.2.1.2
- **PostgreSQL**: Asegúrate de tener postgreSQL instalado en tu computadora y ejecutándose.

## Instalación

1. **Clona el repositorio:**

```bash
git clone https://github.com/JorgeVF00/car_administrator
cd car_administrator
```

2. **Instala `bundler`:**
```bash
gem install bundler
```
3. **Instala las gemas necesarias:**
```bash
bundle install
```

## Setup
1. **Setup de la DB:**
```bash
rails db:setup
```

2. **Pre compila los assets:**
```bash
rails assets:precompile
```
## Ejecución de Aplicación

Inicia el servidor con el siguiente comando:
```bash
./bin/rails server
```

Accede a la aplicación desde `http://localhost:3000/`

## Correr Tests

Ejecuta los tests con el siguiente comando:
```bash
bundle exec rspec
```

## API calls

A continuación se listan algunos ejemplos de API requests con `curl`.

1. **Listar todos los carros:**
```bash
curl -X GET http://localhost:3000/api/v1/cars
```
El formato de response tiene paginación por cada 10 registros, por lo que dependiendo del número de Cars que tengas registrados podrías hacer una request con paginación:
```bash
curl -X GET "http://localhost:3000/api/v1/cars?page=2"
```

2. **Detalles sobre un carro en específico:**
```bash
curl -X GET http://localhost:3000/api/v1/cars/1
```
3. **Crear un carro:**
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"car": {"plate_number": "Test123", "model": "Tesla", "year": 2010}}' \
  http://localhost:3000/api/v1/cars
```
4. **Eliminar un carro:**
```bash
curl -X DELETE http://localhost:3000/api/v1/cars/1
```
5. **Listar todos los servicios de mantenimiento:**
```bash
curl -X GET http://localhost:3000/api/v1/maintenance_services
```
MaintenanceServices también tiene formato de paginación (por 5), por lo que si tienes más de 5 registros puedes hacer un request a otra página:
```bash
curl -X GET "http://localhost:3000/api/v1/maintenance_services?page=2"
```
6. ***Crear un servicio de mantenimiento:**
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"maintenance_service": {"car_id": 1, "status": "in_progress", "description": "De rutina", "date": "2024-10-20"}}' \
  http://localhost:3000/api/v1/maintenance_services
```
