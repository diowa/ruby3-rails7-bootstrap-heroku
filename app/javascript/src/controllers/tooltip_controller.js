import { Controller } from '@hotwired/stimulus'
import Tooltip from 'bootstrap/js/src/tooltip'

export default class extends Controller {
  connect () {
    this.tooltip = new Tooltip(this.element)
  }

  disconnect () {
    this.tooltip.dispose()
  }
}
