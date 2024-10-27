import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "actions", "submit"]

  connect() {
    this.toggleActions()
  }

  toggleActions() {
    const hasContent = this.contentTarget.value.trim().length > 0
    this.actionsTarget.classList.toggle("hidden", !hasContent)
    this.submitTarget.disabled = !hasContent
  }

  handleInput() {
    this.toggleActions()
  }

  handleFocus() {
    this.toggleActions()
  }

  handleBlur() {
    this.toggleActions()
  }

  clearContent() {
    this.contentTarget.value = ""
    this.toggleActions()
  }
}
