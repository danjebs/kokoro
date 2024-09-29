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
        onEnd: this.end.bind(this),
      })
    })
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
