module ApplicationHelper

  def check_mission_open_number

    number = 0
    friendships = Friendship.where(:user_id => current_user.id)
    friendships.each do |f|
      unless f.interactions.last.v2_all_done?
        number += 1
      end
    end
    number
  end

end
