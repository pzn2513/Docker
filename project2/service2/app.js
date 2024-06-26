const express = require('express');
const app = express();
const port = 3000;
const axios = require('axios');

app.get('/', async (req, res) => {
  try {
    const response = await axios.get('http://project1-service1-1:3000/');
    res.send(`Service 2 got message: ${response.data}`);
  } catch (error) {
    res.send('Failed to reach Service 1');
  }
});

app.listen(port, () => {
  console.log(`Service 2 listening at http://localhost:${port}`);
});
