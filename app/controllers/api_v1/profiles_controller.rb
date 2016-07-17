class ApiV1::ProfilesController < ApiController

  def me
    @profile = current_user.profile
    @photos = []
    @profile.photos.each do |image|
      @photos << {url: root_url + image.photo.url(:medium)}
    end
    @hobbies = []
    @profile.hobbies.each do |hobby|
      @hobbies << {name: hobby.name}
    end
  end

end
