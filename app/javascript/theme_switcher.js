document.addEventListener('DOMContentLoaded', function() {
  const themeSwitch = document.getElementById('theme-switch');
  
  if (!themeSwitch) return;
  
  // Theme switcher functionality
  themeSwitch.addEventListener('click', function() {
    if (document.body.getAttribute('data-theme') === 'dark') {
      document.body.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
      themeSwitch.textContent = '🌓';
    } else {
      document.body.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
      themeSwitch.textContent = '☀️';
    }
  });
  
  // Check for saved theme preference
  const savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'dark') {
    document.body.setAttribute('data-theme', 'dark');
    themeSwitch.textContent = '☀️';
  } else {
    // Check system preference if no saved preference
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    if (prefersDark) {
      document.body.setAttribute('data-theme', 'dark');
      themeSwitch.textContent = '☀️';
    }
  }
}); 