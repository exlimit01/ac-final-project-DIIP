module ProfilesHelper

  def make_friend_signs(profile)

    total_sign_tag = String.new

    friendships = current_user.friendships.where(friend_id: profile.user.id)

    if friendships.count == 0 || friendships.first.status == "none"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "喜歡", friendships_like_path(friend_id: profile.user.id), class: "btn btn-default", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td></td>"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td></td>"
    elsif friendships.first.status == "liked"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "已喜歡", friendships_like_path(friend_id: profile.user.id), class: "btn btn-success disabled", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td>"
      total_sign_tag += link_to("不喜歡了", friendships_none_path(friend_id: profile.user.id), class: "btn btn-warning", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td></td>"
    elsif friendships.first.status == "blocked"
      total_sign_tag += "<td></td>"
      total_sign_tag += "<td></td>"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger disabled", method: :post)
      total_sign_tag += "</td>"
      total_sign_tag += "<td>"
      total_sign_tag += link_to( "解除封鎖", friendships_none_path(friend_id: profile.user.id), class: "btn btn-primary", method: :post)
      total_sign_tag += "</td>"
    end

    total_sign_tag.html_safe

  end





end
