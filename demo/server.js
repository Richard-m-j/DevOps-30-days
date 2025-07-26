const express = require('express');
const os = require('os');

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    // Read config from environment variables
    const appTitle = process.env.APP_TITLE || 'JS Demo App';
    const backgroundColor = process.env.BACKGROUND_COLOR || '#27AE60'; // A green color for JS
    const hostname = os.hostname();

    const html = `
    <body style="background-color: #f0f4f8;">
        <div style="font-family: 'Helvetica Neue', sans-serif;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;">
            <div style="background-color: ${backgroundColor};
                        color: white;
                        padding: 50px;
                        border-radius: 15px;
                        text-align: center;
                        box-shadow: 0 10px 20px rgba(0,0,0,0.15);">
                <h1 style="font-size: 2.5em; margin-bottom: 10px;">${appTitle}</h1>
                <p style="font-size: 1.2em;">This response was served by pod:</p>
                <h2 style="background-color: #FFFFFF;
                           color: #333;
                           padding: 10px 20px;
                           border-radius: 8px;
                           font-family: 'Courier New', monospace;">${hostname}</h2>
            </div>
        </div>
    </body>
    `;
    res.send(html);
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT}`);
});