import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "./controllers"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true // Zapneme debug mode
window.Stimulus   = application

console.log("Stimulus initialized") // Pre debugging

document.addEventListener('DOMContentLoaded', function() {
  console.log("DOM fully loaded");
});

export { application }
