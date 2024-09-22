class Board < ApplicationRecord
  belongs_to :creator, class_name: :User

  has_many :participants, class_name: :User

  attribute :status, :string
  enum status: { active: "active", archived: "archived" }, _prefix: :status_is

  validates :name, presence: true, uniqueness: { scope: :creator_id }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :active
  end
end
