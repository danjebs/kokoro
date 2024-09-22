class TaskStatus < ApplicationRecord
  belongs_to :board

  acts_as_list scope: :board_id

  validates :name, presence: true, uniqueness: { scope: :board_id }
end
