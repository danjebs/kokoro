class User < ApplicationRecord
  rolify

  has_many :boards, through: :roles, source: :resource, source_type: "Board"

  validates :name, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
