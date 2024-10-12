class Board < ApplicationRecord
  belongs_to :creator, class_name: :User

  has_many :task_statuses, dependent: :destroy
  has_many :collaborators, as: :collaborateable
  has_many :users, through: :collaborators

  attribute :status, :string
  enum status: { active: "active", archived: "archived" }, _prefix: :status_is

  validates :name, presence: true, uniqueness: { scope: :creator_id }

  after_initialize :set_default_status, if: :new_record?
  after_create :create_default_task_statuses
  after_create :add_creator_as_collaborator

  scope :accessible_by, ->(user) {
    return none if user.nil?

    joins(:collaborators).where(collaborators: { user_id: user.id })
  }

  private

  def set_default_status
    self.status ||= :active
  end

  def create_default_task_statuses
    task_statuses.create(name: "To Do", state: "inactive")
    task_statuses.create(name: "Doing", state: "active")
    task_statuses.create(name: "Done", state: "archived")
  end

  def add_creator_as_collaborator
    collaborators.create(user: creator)
  end
end
