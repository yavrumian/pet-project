# Python Flask Weather App

This is a simple Flask application that fetches and displays the current weather in London, UK, using the OpenWeatherMap API. The application also includes endpoints for checking the server's health and ping.

## Table of Contents

- [Python Flask Weather App](#python-flask-weather-app)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Endpoints](#endpoints)
  - [Configuration](#configuration)

## Prerequisites

Before running the application, ensure you have the following installed:

- Python (3.x recommended)
- Flask
- Requests

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/naviteq/lab-work-vahe-yavrumian
   cd lab-work-vahe-yavrumian
   ```
2. Install dependencies:

```bash
pip install -r requirements.txt
```

## Usage

**Run the application:**

```bash
EXPORT FLASK_APP=server.py
flask run --host=0.0.0.0
```

The application will be accessible at [http://localhost:5000/]().

## Endpoints

    **Ping: /ping** - Get pong.
    **Current Weather: /** - Display the current weather in London, UK.
    **Health Check: /health** - Check the health of the server.

## Configuration

1. Provide your OpenWeatherMap API key:
   * Create an account on OpenWeatherMap and obtain an API key.
   * Save the API key in a file at the specified path: /mnt/secrets/python-app.
