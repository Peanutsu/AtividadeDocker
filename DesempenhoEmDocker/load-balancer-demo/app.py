from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route('/')
def home():
    container_name = socket.gethostname()
    return jsonify({
        'message': 'Hello from backend!',
        'container': container_name,
        'hostname': os.getenv('HOSTNAME', container_name)
    })

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
