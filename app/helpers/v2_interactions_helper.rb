module V2InteractionsHelper

   def v2_show_interaction_status(interaction)

    total_link_tag = ""
    if interaction.v2_all_none?
      # 一開始
      total_link_tag += link_to "接受", v2_interactions_ok_path(:user_id => interaction.friendship.user_id,
                        :friend_id => interaction.friendship.friend_id, :interaction_id => interaction.id,
                        :mission_id => interaction.mission_id), :class => "btn btn-default", method: :post
      total_link_tag += link_to "拒絕", v2_interactions_no_path(:user_id => interaction.friendship.user_id,
                        :friend_id => interaction.friendship.friend_id, :interaction_id => interaction.id,
                        :mission_id => interaction.mission_id), :class => "btn btn-default", method: :post

    elsif interaction.v2_other_accept?
      # 自己接受，等候對方
      total_link_tag += link_to "已接受 等待對方同意", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_accept_and_wait?
      # 對方接受，等待自己接受
      total_link_tag += link_to "對方已接受", "#", :class => "btn btn-default disabled"
      total_link_tag += link_to "接受", v2_interactions_ok_path(:user_id => interaction.friendship.user_id,
                        :friend_id => interaction.friendship.friend_id, :interaction_id => interaction.id,
                        :mission_id => interaction.mission_id), :class => "btn btn-default", method: :post
      total_link_tag += link_to "拒絕", v2_interactions_no_path(:user_id => interaction.friendship.user_id,
                        :friend_id => interaction.friendship.friend_id, :interaction_id => interaction.id,
                        :mission_id => interaction.mission_id), :class => "btn btn-default", method: :post

    elsif interaction.v2_reject_other?
      # 自己拒絕
      total_link_tag += link_to "已拒絕", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_other_reject?
      # 對方拒絕
      total_link_tag += link_to "對方已拒絕", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_start?
      # 雙方開始
      total_link_tag += link_to "任務開始", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_me_done?
      # 自己結束  等待對方結束
      total_link_tag += link_to "等待對方結束", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_other_done?
      total_link_tag += link_to "對方結束任務", "#", :class => "btn btn-default disabled"

    elsif interaction.v2_all_done?
      # 雙方結束
      total_link_tag += link_to "任務結束", "#", :class => "btn btn-default disabled"
    end
    total_link_tag.html_safe
  end

end
