class TaskStatus < ApplicationRecord
  belongs_to :board

  has_many :tasks

  attribute :state, :string
  enum state: { inactive: "inactive", active: "active", archived: "archived" }, _prefix: :state_is

  validates :name, presence: true, uniqueness: { scope: :board_id }

  acts_as_list scope: :board_id

  scope :ordered, -> { order(position: :asc) }
end
