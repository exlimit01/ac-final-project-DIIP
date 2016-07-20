module InteractionsHelper

  def show_interaction_status(interaction)

    total_link_tag = String.new
    if interaction.none?
      total_link_tag += link_to("送出", interactions_ask_path(:user_id => interaction.friendship.user_id,
                  :friend_id => interaction.friendship.friend_id,
                  :mission_id => interaction.mission_id), method: :post ,class: "btn btn-default")
      total_link_tag += link_to("換一個", interactions_reset_path(:user_id => interaction.friendship.user_id,
                  :friend_id => interaction.friendship.friend_id,
                  :mission_id => interaction.mission_id), class: "btn btn-default", :remote => true)
    elsif interaction.request?
      total_link_tag += link_to("已送出", "#", class: "btn btn-warning disabled")
      total_link_tag += link_to("取消", interactions_no_path(:interaction_id => interaction.id), method: :post ,class: "btn btn-default")

    elsif interaction.accept?
      total_link_tag += link_to("已接受", "#", class: "btn btn-success disabled")
      total_link_tag += link_to("完成", interactions_done_path, class: "btn btn-primary")
      total_link_tag += link_to("取消", interactions_no_path(:interaction_id => interaction.id, :double => true), method: :post, class: "btn btn-default")

    end
    total_link_tag.html_safe
  end

  def current_inverse_interaction_item(interaction)

    total_link_tag = String.new
    if interaction.request?
      total_link_tag += link_to("接受", interactions_ok_path(:interaction_id => interaction.id) ,class: "btn btn-default", :method => :post)
      total_link_tag += link_to("取消", interactions_no_path(:interaction_id => interaction.id, :opposite => true), class: "btn btn-default", :method => :post)
    end
    total_link_tag.html_safe

  end

end
