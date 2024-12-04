
document.addEventListener('DOMContentLoaded', () => {
    const gameGrid = document.getElementById('game-grid');

    // Fetch game data from the server
    fetch('/api/games')
        .then(response => response.json())
        .then(games => {
            games.forEach(game => {
                const card = document.createElement('a');
                card.href = `game.html?id=${game.id}`;
                card.classList.add('game-card');

                card.innerHTML = `
                    <img src="${game.image}" alt="${game.title}" class="game-image" />
                    <h2>${game.title}</h2>
                    <p><strong>Platform:</strong> ${game.platform}</p>
                    <p><strong>Year:</strong> ${game.year}</p>
                    <p class="game-description">${game.description}</p>
                `;

                gameGrid.appendChild(card);
            });
        })
        .catch(error => console.error('Error fetching game data:', error));
});


