module ApplicationHelper

  def check_mission_open_number

    number = 0
    friendships = Friendship.where(:user_id => current_user.id)
    friendships.each do |f|
      if f.interactions.count != 0
        unless f.interactions.last.v2_all_done?
          number += 1
        end
      end
    end
    number
  end

end
