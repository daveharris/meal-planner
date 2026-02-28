import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  update(event) {
    const input = this.element;

    input.form.requestSubmit();

    // Mark field as invalid to show Add Pico success tick
    input.setAttribute("aria-invalid", "false")

    setTimeout(() => input.removeAttribute("aria-invalid"), 3000);
  }

  connect() {
  }
}
