const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Welcome to the Simple App');
});

const port = process.env.PORT || 8080;

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});