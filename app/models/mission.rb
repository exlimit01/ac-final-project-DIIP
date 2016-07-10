class Mission < ApplicationRecord

  has_many :interactions, dependent: :destroy
  has_many :friendships, through: :interactions

end
