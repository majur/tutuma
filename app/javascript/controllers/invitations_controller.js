import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "container"]

  connect() {
    console.log("Invitations controller connected")
  }

  addRow(event) {
    console.log("addRow called")
    event.preventDefault()
    
    const template = this.element.querySelector('.invitation-row')
    console.log("Template found:", template)
    
    if (!template) {
      console.error("Template not found")
      return
    }

    const newRow = template.cloneNode(true)
    const inputs = newRow.querySelectorAll('input')
    
    inputs.forEach(input => {
      input.value = ''
    })

    const container = this.element.querySelector('#invitation-fields')
    if (container) {
      container.appendChild(newRow)
      console.log("New row added")
    } else {
      console.error("Container not found")
    }
  }
} 