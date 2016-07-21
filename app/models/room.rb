class Room < ApplicationRecord
  has_many :interactions
  has_many :talks, dependent: :destroy

  def active?
    self.active == true
  end
end
