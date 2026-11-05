import os
from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)
requests = Counter("lab3_http_requests_total", "Total HTTP requests")

@app.route("/")
def home():
    requests.inc()
    if os.getenv("ENABLE_NEW_FEATURE", "false").lower() == "true":
        return "DevOps Lab 3 - NEW FEATURE ENABLED"
    return "DevOps Lab 3 - Prometheus Monitoring"

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)
