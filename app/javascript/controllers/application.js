import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true // Zapneme debug mode
window.Stimulus   = application

console.log("Stimulus initialized") // Pre debugging

export { application }
