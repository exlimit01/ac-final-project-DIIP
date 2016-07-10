class Profile < ApplicationRecord
  belongs_to :user

  has_many :hobby_tags, dependent: :destroy
  has_many :hobbies, through: :hobby_tags
end
