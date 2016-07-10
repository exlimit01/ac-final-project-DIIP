class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: "User"

  has_many :qa_customs, dependent: :destroy

  has_many :interactions, dependent: :destroy
  has_many :missions, through: :interactions

end
