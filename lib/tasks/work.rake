namespace :work do

  task :refresh_interactions => :environment do

    Friendship.all.each do |friendship|
      if friendship.mission_open?

        if friendship.interactions.count == 0 || friendship.interactions.last.co_status == 8

          user_id = friendship.user_id
          friend_id = friendship.friend_id
          inverse_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)

          m = Mission.all.sample
          friendship.interactions.create!(:mission_id => m.id, :co_status => -1)
          inverse_friendship.interactions.create!(:mission_id => m.id, :co_status => -1)

        elsif friendship.interactions.last.co_status < 5 && friendship.interactions.last.co_status != -1

          user_id = friendship.user_id
          friend_id = friendship.friend_id
          inverse_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)

          m = Mission.all.sample
          friendship.interactions.last.update!(:mission_id => m.id, :co_status => -1)
          inverse_friendship.interactions.last.update!(:mission_id => m.id, :co_status => -1)

        end

      end
    end

    Interaction.where(:co_status => -1).update(:co_status => 0)

  end

end