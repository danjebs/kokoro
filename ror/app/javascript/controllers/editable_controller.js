import { Controller } from "@hotwired/stimulus"
import { patch } from '@rails/request.js'

export default class extends Controller {
  static targets = ["input"]

  // TODOD: cleanup required?
  connect() {
    this.element.contentEditable = true
    this.element.dataset.action = 'blur->editable#handleChange input->editable#handleInput'

    this.element.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
          event.preventDefault()
          this.element.blur()
      }
    })

    this.debouncedUpdate = this.debounce(this.update.bind(this), 3000)
  }

  async update() {
    const input = this.element

    const response = await patch(input.dataset.url, {
      body: JSON.stringify({
        [input.dataset.model]: {
          [input.dataset.field]: input.innerText
        }
      }),
      responseKind: 'json'
    })
  }

  handleChange() {
    this.update()
  }

  handleInput() {
    this.debouncedUpdate()
  }

  debounce(func, wait) {
    let timeout
    return function(...args) {
      const context = this
      clearTimeout(timeout)
      timeout = setTimeout(() => func.apply(context, args), wait)
    }
  }
}
