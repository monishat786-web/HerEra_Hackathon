document.addEventListener('DOMContentLoaded', () => {
    // Collapsible Logic
    const cards = document.querySelectorAll('.glass-card.collapsible');
    
    // Expand the first card by default for a nice view
    if (cards.length > 0) {
        cards[0].classList.add('expanded');
    }

    cards.forEach(card => {
        const header = card.querySelector('.card-header');
        header.addEventListener('click', () => {
            // Optional: Close other cards when opening one
            // cards.forEach(c => { if(c !== card) c.classList.remove('expanded'); });
            
            card.classList.toggle('expanded');
        });
    });

    // Handle Edit/Action clicks
    const editIcons = document.querySelectorAll('.edit-icon, .actions i, .add-icon');
    editIcons.forEach(icon => {
        icon.addEventListener('click', (e) => {
            e.stopPropagation(); // Don't trigger collage
            const action = icon.getAttribute('data-lucide');
            console.log(`Action triggered: ${action}`);
        });
    });

    // Lucide Icon refresh if needed (already handled in HTML script tag usually)
});
