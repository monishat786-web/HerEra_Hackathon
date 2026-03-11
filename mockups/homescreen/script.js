document.addEventListener('DOMContentLoaded', () => {
    const sosButton = document.getElementById('sosTrigger');
    
    sosButton.addEventListener('click', () => {
        // Mock SOS activation
        sosButton.style.transform = 'scale(1.1)';
        sosButton.style.boxShadow = '0 0 100px #FF3B30';
        
        setTimeout(() => {
            sosButton.style.transform = 'scale(1)';
            alert('SOS Emergency Alert Triggered! Help is on the way.');
        }, 200);
    });

    // Add subtle hover sound or haptic feedback mock
    const actionItems = document.querySelectorAll('.icon-circle');
    actionItems.forEach(item => {
        item.addEventListener('mouseenter', () => {
            // Log for context
            console.log('User exploring: ' + item.nextElementSibling.textContent);
        });
    });
});
