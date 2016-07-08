class Question < ApplicationRecord

  has_many :answers, dependent: :destroy
  has_many :users, through: :answers

end
