import requests
import json

BASE_URL = "http://127.0.0.1:8000"

# Load JSON data for register
with open("register.json", "r") as reg_file:
    register_data = json.load(reg_file)

# Send POST request to register
register_response = requests.post(f"{BASE_URL}/registration/", json=register_data)
print("Register Response:", register_response.status_code, register_response.json())

# Load JSON data for login
with open("login.json", "r") as login_file:
    login_data = json.load(login_file)

# Send POST request to login
login_response = requests.post(f"{BASE_URL}/log_in/", json=login_data)
print("Login Response:", login_response.status_code, login_response.json())
