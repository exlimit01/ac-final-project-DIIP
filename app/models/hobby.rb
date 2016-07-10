class Hobby < ApplicationRecord

  has_many :hobby_tags, dependent: :destroy
  has_many :profiles, through: :hobby_tags

end
