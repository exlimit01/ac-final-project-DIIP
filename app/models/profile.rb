class Profile < ApplicationRecord
  belongs_to :user

  has_many :hobby_tags, dependent: :destroy
  has_many :hobbies, through: :hobby_tags

  has_many :profession_tags, dependent: :destroy
  has_many :professions, through: :profession_tags

  belongs_to :location

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :photos, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :questions, through: :answers

end
