import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    this.element.reset()
    
    // ?. JS safe operator
    this.element.querySelector("[autofocus='autofocus']")?.focus()

    // this.element.querySelector("input:not([type=hidden])").focus()
  }
}
