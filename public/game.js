// Extract query parameters
const urlParams = new URLSearchParams(window.location.search);
const gameId = parseInt(urlParams.get('id'), 10);

// Mock game data
const games = [
    {
        id: 1,
        title: "Super Pixel Bros",
        platform: "NES",
        year: 1985,
        description: "A classic side-scrolling platformer.",
        image: "https://via.placeholder.com/200x150?text=Super+Pixel+Bros"
    },
    {
        id: 2,
        title: "Mega Racer",
        platform: "SNES",
        year: 1991,
        description: "High-octane racing action.",
        image: "https://via.placeholder.com/200x150?text=Mega+Racer"
    },
    {
        id: 3,
        title: "Pixel Quest",
        platform: "Game Boy",
        year: 1990,
        description: "Adventure in a pixelated world.",
        image: "https://via.placeholder.com/200x150?text=Pixel+Quest"
    },
    // Add more games with their respective images...
];


// Display game details
document.addEventListener('DOMContentLoaded', () => {
    const game = games.find(g => g.id === gameId);

    if (game) {
        document.getElementById('game-title').textContent = game.title;
        document.getElementById('game-details').textContent = `${game.platform} | ${game.year}`;
        document.getElementById('game-emulator-name').textContent = game.title;
    } else {
        document.querySelector('.emulator-container').innerHTML = `<p>Game not found.</p>`;
    }
});
