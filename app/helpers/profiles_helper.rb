module ProfilesHelper
  def make_friend_signs(profile)
    total_sign_tag = String.new
    friendships = current_user.friendships.where(friend_id: profile.user.id)
    if friendships.count == 0 || friendships.first.status == "none"
      total_sign_tag += link_to( "喜歡", friendships_like_path(friend_id: profile.user.id), class: "btn btn-default", method: :post)
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger", method: :post)
    elsif friendships.first.status == "liked"
      total_sign_tag += link_to( "已喜歡", friendships_like_path(friend_id: profile.user.id), class: "btn btn-success disabled", method: :post)
      total_sign_tag += link_to("不喜歡了", friendships_none_path(friend_id: profile.user.id), class: "btn btn-warning", method: :post)
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger", method: :post)
    elsif friendships.first.status == "blocked"
      total_sign_tag += link_to( "封鎖", friendships_block_path(friend_id: profile.user.id), class: "btn btn-danger disabled", method: :post)
      total_sign_tag += link_to( "解除封鎖", friendships_none_path(friend_id: profile.user.id), class: "btn btn-primary", method: :post)
    end
    total_sign_tag.html_safe
  end

  def make_answer_list(profile)
    total_answers_tag = String.new
    answers = profile.get_lasest_3_answers
    answers.each do |answer|
      total_answers_tag += "<h4>"
      total_answers_tag += answer.question.content
      total_answers_tag += "</h4>"
      total_answers_tag += "<p>"
      total_answers_tag += answer.content
      total_answers_tag += "</p>"
    end
    total_answers_tag.html_safe
  end

end
