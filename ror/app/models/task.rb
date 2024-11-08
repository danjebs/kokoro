class Task < ApplicationRecord
  include Commentable

  belongs_to :board, touch: true
  belongs_to :task_status
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  broadcasts_refreshes

  acts_as_list scope: :task_status

  before_save :set_position, if: :new_record?

  validates :name, presence: true

  scope :accessible_by, ->(user) {
    return none if user.nil?

    joins(board: :users).where(users: { id: user.id })
  }
  scope :ordered, -> { order(position: :asc) }

  def assignee_name
    assignee.present? ? assignee.name : "Unassigned"
  end

  def accessible_by?(user)
    board.users.exists?(user.id)
  end

  def status_label
    task_status&.name
  end

  private

  def set_position
    self.position ||= Task.where(task_status_id: task_status_id).count + 1
  end
end
