class Answer < ApplicationRecord

  validates_presence_of :question_id
  validates_presence_of :content

  belongs_to :profile
  belongs_to :question

end
