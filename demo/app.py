from flask import Flask
import socket
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # Get config from environment variables
    app_title = os.environ.get('APP_TITLE', 'Kubernetes Demo App')
    background_color = os.environ.get('BACKGROUND_COLOR', '#5D3FD3')
    hostname = socket.gethostname()

    html = f"""
    <body style="background-color: #f0f4f8;">
        <div style="font-family: 'Helvetica Neue', sans-serif;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;">
            <div style="background-color: {background_color};
                        color: white;
                        padding: 50px;
                        border-radius: 15px;
                        text-align: center;
                        box-shadow: 0 10px 20px rgba(0,0,0,0.15);">
                <h1 style="font-size: 2.5em; margin-bottom: 10px;">{app_title}</h1>
                <p style="font-size: 1.2em;">This response was served by pod:</p>
                <h2 style="background-color: #FFFFFF;
                           color: #333;
                           padding: 10px 20px;
                           border-radius: 8px;
                           font-family: 'Courier New', monospace;">{hostname}</h2>
            </div>
        </div>
    </body>
    """
    return html

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)