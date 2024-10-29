import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'

export default class extends Controller {
  connect() {
    this.element.dataset.action = "change->selectable#submit"
  }

  async submit(event) {
    const { field, url } = this.element.dataset
    const value = event.target.value

    await patch(url, {
      body: JSON.stringify({ [field]: value }),
      responseKind: 'json'
    })
  }
}
