const express = require('express');
const os = require('os');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    res.send(`Hello from Kubernetes! This response was served by pod: ${os.hostname()}`);
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT}`);
});