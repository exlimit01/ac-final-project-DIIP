namespace :dev do

  task :fake => :environment do

    puts "Cleaning Data"
    User.destroy_all
    Profile.destroy_all

    puts "Creating fake data!"

    user = User.create!(:email => "yakushou730@gmail.com", :password => "000000")
    Profile.create!(:nickname => "Yao-Shang", :user_id => user.id,
                          :age => 18,
                          :description => "Go Go Go",
                          :facebook_link => "https://www.facebook.com/yakushou730",
                          :facebook_access_level => 10,
                          :line_account => "yakushou730",
                          :line_access_level => 20,
                          :wechat_account => "yakushou730",
                          :wechat_access_level => 30,
                          :location_id => 3)

    10.times do |i|
      u = User.create!(:email =>  Faker::Internet.email, :password => "000000")
      p = Profile.create!(:nickname => Faker::Name.name,
                          :user_id => u.id,
                          :age => Faker::Number.between(18, 30),
                          :description => Faker::Lorem.sentence,
                          :facebook_link => Faker::Internet.url('facebook.com'),
                          :facebook_access_level => Faker::Number.between(0, 100),
                          :line_account => Faker::Name.name,
                          :line_access_level => Faker::Number.between(0, 100),
                          :wechat_account => Faker::Name.name,
                          :wechat_access_level => Faker::Number.between(0, 100),
                          :location_id => Faker::Number.between(2, 21))
    end

  end

end