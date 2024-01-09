from flask import Flask, jsonify
import requests
import os

app = Flask(__name__)

import json

# Define the path to the file containing API key
file_path = "/mnt/secrets/python-app"

# Minimal CSS style for better presentation
MINIMAL_STYLE = '<style>body { font-family: Arial, sans-serif; margin: 20px; }</style>'

# Endpoint for checking if the server is running
@app.route('/ping')
def ping():
    return MINIMAL_STYLE + '<html><body><h1>PONG</h1></body></html>', 200

# Endpoint for fetching and displaying the current weather
@app.route('/')
def current_weather():
    try:
        # Read API key from the specified file
        with open(file_path, "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        print(f"Error: File not found at {file_path}")
    except json.JSONDecodeError:
        print(f"Error: Unable to decode JSON from file at {file_path}")
    except Exception as e:
        print(f"Error: An unexpected error occurred - {e}")
    
    api_key = data['key']
    weather_url = 'https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=' + api_key

    # Make a request to the OpenWeatherMap API
    response = requests.get(weather_url)
    data = response.json()

    # Extract temperature and weather description from the API response
    temperature = data['main']['temp']
    weather_description = data['weather'][0]['description']

    # Create an HTML response with weather information
    html_response = f"{MINIMAL_STYLE}<html><body><h1>Current Weather in London, UK</h1><p>Temperature: {temperature}°C</p><p>Description: {weather_description}</p></body></html>"
    return html_response, 200

# Endpoint for checking the health of the server
@app.route('/health')
def health():
    health_data = {'status': 'HEALTHY'}
    return jsonify(health_data), 200

# Run the Flask app if the script is executed
if __name__ == '__main__':
    app.run(debug=False)
