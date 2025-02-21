import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Invitations controller connected!")
  }

  addRow() {
    console.log("Adding new row...")
    const template = this.element.querySelector('.invitation-row').cloneNode(true)
    
    // Reset all input values in the cloned template
    const inputs = template.querySelectorAll('input[type="text"], input[type="email"]')
    inputs.forEach(input => {
      input.value = ''
      
      // Generate new unique IDs and names
      const timestamp = new Date().getTime()
      const oldId = input.id
      const newId = `invitations_${timestamp}_${input.name.includes('email') ? 'email' : 'name'}`
      
      input.id = newId
      input.name = `invitations[][${input.name.includes('email') ? 'email' : 'name'}]`
      
      // Update associated label if it exists
      const label = template.querySelector(`label[for="${oldId}"]`)
      if (label) {
        label.setAttribute('for', newId)
      }
    })
    
    // Add the new row
    this.element.querySelector('#invitation-fields').appendChild(template)
  }
} 