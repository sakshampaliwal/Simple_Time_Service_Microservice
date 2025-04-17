from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_time_and_ip():
    """
    Return the current timestamp and visitor's IP address as JSON.
    """
    # Get current timestamp
    current_time = datetime.now().isoformat()
    
    # Get visitor's IP address
    visitor_ip = request.remote_addr
    
    # Create response JSON
    response_data = {
        "timestamp": current_time,
        "ip": visitor_ip
    }
    
    return jsonify(response_data)

if __name__ == '__main__':
    # Run on all interfaces (0.0.0.0) to be accessible from outside the container
    app.run(host='0.0.0.0', port=5000)