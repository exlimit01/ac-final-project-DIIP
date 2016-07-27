class Answer < ApplicationRecord

  validates_presence_of :question_id
  validates_presence_of :content

  belongs_to :profile
  belongs_to :question

  has_many :like_answers, dependent: :destroy
  has_many :friendships, through: :like_answers

end
