import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const themeSwitch = this.element.querySelector('#theme-switch');
    
    if (themeSwitch) {
      // Theme switcher functionality
      themeSwitch.addEventListener('click', this.toggleTheme.bind(this));
      
      // Check for saved theme preference
      this.initializeTheme();
    }
  }
  
  toggleTheme() {
    const themeSwitch = this.element.querySelector('#theme-switch');
    
    if (document.body.getAttribute('data-theme') === 'dark') {
      document.body.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
      themeSwitch.textContent = '🌓';
    } else {
      document.body.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
      themeSwitch.textContent = '☀️';
    }
  }
  
  initializeTheme() {
    const themeSwitch = this.element.querySelector('#theme-switch');
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
  }
} 