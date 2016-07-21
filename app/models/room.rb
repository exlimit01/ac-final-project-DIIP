class Room < ApplicationRecord
  has_many :interactions
  has_many :talks, dependent: :destroy
end
