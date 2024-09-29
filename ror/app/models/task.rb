class Task < ApplicationRecord
  belongs_to :board
  belongs_to :task_status
  belongs_to :creator, class_name: :User
  belongs_to :assignee, class_name: :User, optional: true

  validates :title, presence: true, uniqueness: { scope: :board_id }

  acts_as_list scope: :task_status_id

  scope :ordered, -> { order(position: :asc) }

  def status
    task_status.name
  end
end
