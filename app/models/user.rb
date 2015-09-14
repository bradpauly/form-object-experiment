class User < ActiveRecord::Base
  has_one :organization

  attr_accessor :password

  validates :name, presence: { message: "Please enter your name" }
  validates :email, presence: { message: "An email address is required" }
  validates :email, uniqueness: { message: "Email is already registered" }
  validates :email, format: { with: /@/, message: "Email must contain an @, for example: pat@example.com" }
end
