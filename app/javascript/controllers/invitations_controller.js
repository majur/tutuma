import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  addRow() {
    const template = this.element.querySelector('.invitation-row').cloneNode(true)
    const inputs = template.querySelectorAll('input')
    inputs.forEach(input => input.value = '')
    this.element.querySelector('#invitation-fields').appendChild(template)
  }
} 