class Profession < ApplicationRecord

  has_many :profession_tags, dependent: :destroy
  has_many :users, through: :profession_tags

end
