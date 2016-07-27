class Answer < ApplicationRecord

  validates_presence_of :question_id
  validates_presence_of :content

  belongs_to :profile
  belongs_to :question

  has_many :like_answers, dependent: :destroy
  has_many :friendships, through: :like_answers

  def liked?(user)
    if self.friendships.where(:user_id => user.id).count > 0
      true
    else
      false
    end
  end

end
