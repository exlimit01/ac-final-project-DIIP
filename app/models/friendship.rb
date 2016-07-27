class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: "User"

  has_many :qa_customs, dependent: :destroy

  has_many :interactions, dependent: :destroy
  has_many :missions, through: :interactions

  has_many :like_answers, dependent: :destroy
  has_many :answers, through: :like_answers

  def mission_open?
    forward_friendship = Friendship.find_by(user_id: self.user_id, friend_id: self.friend_id)
    backward_friendship = Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
    [forward_friendship.love_level, backward_friendship.love_level].min >= 0
  end

end
