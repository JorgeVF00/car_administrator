import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.submit = this.submit.bind(this)
  }

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 300)
  }
}