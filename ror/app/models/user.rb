class User < ApplicationRecord
  validates :name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
