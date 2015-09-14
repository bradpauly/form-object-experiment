class Organization < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: { message: "Company or organization name is required" }
end
