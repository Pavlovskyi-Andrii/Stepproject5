import os
import socket
from flask import Flask, jsonify


app = Flask(__name__)


@app.route('/')
def root():
    pod_ip = socket.gethostbyname(socket.gethostname())
    return jsonify({"status": "ok", "pod_ip": pod_ip})


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port)