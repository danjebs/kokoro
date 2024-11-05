class Board < ApplicationRecord
  include Collaborateable

  resourcify

  belongs_to :creator, class_name: :User

  has_many :tasks
  has_many :task_statuses, dependent: :destroy
  has_many :users, through: :roles

  broadcasts_refreshes

  enum :status, { active: "active", archived: "archived" }, prefix: :status_is

  validates :name, presence: true, uniqueness: { scope: :creator_id }

  after_initialize :set_default_status, if: :new_record?
  after_create :create_default_task_statuses

  private

  def set_default_status
    self.status ||= :active
  end

  def create_default_task_statuses
    task_statuses.create(name: "To Do", state: "inactive")
    task_statuses.create(name: "Doing", state: "active")
    task_statuses.create(name: "Done", state: "archived")
  end
end
