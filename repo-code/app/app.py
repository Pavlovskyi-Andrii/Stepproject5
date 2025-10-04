import os
import socket
from datetime import datetime
from flask import Flask

app = Flask(__name__)

@app.route('/')
def root():
    pod_ip = socket.gethostbyname(socket.gethostname())
    now = datetime.now().strftime("%d.%m.%Y %H:%M:%S")

    html = f"""
    <html>
    <head>
        <title>Step 5 Done</title>
        <style>
            body {{
                font-family: 'Segoe UI', sans-serif;
                text-align: center;
                background: linear-gradient(135deg, #1f1c2c, #928dab);
                color: #fff;
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin: 0;
            }}
            .card {{
                background: rgba(255, 255, 255, 0.1);
                padding: 30px 60px;
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(255,255,255,0.2);
            }}
            h1 {{
                font-size: 3em;
                margin-bottom: 10px;
            }}
            p {{
                font-size: 1.2em;
                margin: 5px 0;
            }}
            img {{
                width: 120px;
                margin-bottom: 20px;
            }}
        </style>
    </head>
    <body>
        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" alt="check">
            <h1>Step 5 Done ✅</h1>
            <p><strong>Date:</strong> {now}</p>
            <p><strong>Pod IP:</strong> {pod_ip}</p>
        </div>
    </body>
    </html>
    """
    return html

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port)