class Board < ApplicationRecord
  belongs_to :creator, class_name: :User

  has_many :task_statuses, dependent: :destroy
  has_many :board_users, class_name: "BoardUser"
  has_many :users, through: :board_users

  attribute :status, :string
  enum status: { active: "active", archived: "archived" }, _prefix: :status_is

  validates :name, presence: true, uniqueness: { scope: :creator_id }

  after_initialize :set_default_status, if: :new_record?
  after_create :create_default_task_statuses
  after_create :add_creator_as_board_user

  scope :accessible_by, ->(user) {
    return none if user.nil?

    joins(:board_users).where(board_users: { user_id: user.id })
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

  def add_creator_as_board_user
    board_users.create(user: creator)
  end
end
