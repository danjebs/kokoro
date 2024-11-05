import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'
import Sortable from 'sortablejs'

export default class extends Controller {
  static targets = ['column']

  connect() {
    this.columnTargets.forEach((column) => {
      Sortable.create(column, {
        group: 'tasks',
        animation: 150,
        delay: 300,
        delayOnTouchOnly: true,
        onStart: this.start.bind(this),
        onEnd: this.end.bind(this),
      })

      const preventContextMenu = (event) => {
        const parent = event.target.closest('[id^="listing_task_"]')
        if (parent) {
          event.preventDefault()
        }
      }

      column.querySelectorAll('[id^="listing_task_"]').forEach((link) => {
        link.addEventListener('contextmenu', preventContextMenu)
      })
    })
  }

  start(event) {
    if (navigator.vibrate) {
      navigator.vibrate(50)
    }
  }

  async end(event) {
    const id = event.item.dataset.id
    const newIndex = event.newIndex
    const newStatusId = event.to.dataset.statusId

    const response = await patch(`/tasks/${id}`, {
      body: JSON.stringify({
        task: {
          position: newIndex + 1,
          task_status_id: newStatusId,
        },
      }),
      responseKind: 'json'
    })
  }
}
