import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notification"]

  close() {
    this.notificationTarget.remove();
  }
}