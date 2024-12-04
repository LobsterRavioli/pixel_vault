const express = require('express');
const path = require('path');
const gamesData = require('./data/games.json');

const app = express();

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, 'public')));

// API endpoint to get game data
app.get('/api/games', (req, res) => {
    res.json(gamesData);
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
