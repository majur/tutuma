import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Invitations controller connected!")
  }

  addRow() {
    console.log("Adding new row...")
    const template = this.element.querySelector('.invitation-row').cloneNode(true)
    const inputs = template.querySelectorAll('input')
    inputs.forEach(input => {
      input.value = ''
      // Generate new unique name/id for each input
      const newId = new Date().getTime()
      input.name = input.name.replace(/\[\d*\]/, `[${newId}]`)
      input.id = input.id.replace(/\d+/, newId)
    })
    this.element.querySelector('#invitation-fields').appendChild(template)
  }
} 