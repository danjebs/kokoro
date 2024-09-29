class User < ApplicationRecord
  has_many :board_users, class_name: "BoardUser"
  has_many :boards, through: :board_users

  validates :name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
