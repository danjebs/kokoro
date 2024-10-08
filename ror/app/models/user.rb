class User < ApplicationRecord
  has_many :collaborators
  has_many :boards, through: :collaborators

  validates :name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
