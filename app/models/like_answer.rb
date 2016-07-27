class LikeAnswer < ApplicationRecord
  belongs_to :friendship
  belongs_to :answer
end
