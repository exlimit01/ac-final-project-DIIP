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

  task :set_user => :environment do

    sex_array = ["男", "女"]
    relation_array = ["單身", "交往中", "已婚"]

    puts "清除資料!!"
    User.destroy_all
    Profile.destroy_all
    Hobby.destroy_all
    Profession.destroy_all
    Mission.destroy_all
    Question.destroy_all
    Location.destroy_all
    Friendship.destroy_all
    Interaction.destroy_all
    Avatar.destroy_all

    puts "建立興趣"
    Hobby.create(name: "籃球")
    Hobby.create(name: "游泳")
    Hobby.create(name: "旅遊")
    Hobby.create(name: "聽音樂")
    Hobby.create(name: "逛街")

    puts "建立專業"
    Profession.create(name: "科技")
    Profession.create(name: "金融")
    Profession.create(name: "醫療")
    Profession.create(name: "服務")
    Profession.create(name: "教育")

    puts "建立任務"
    Mission.create(content: "一起去看電影")
    Mission.create(content: "一起去唱歌")
    Mission.create(content: "一起去郊遊")
    Mission.create(content: "一起去健身房")
    Mission.create(content: "一起去爬山")

    puts "建立問題"
    Question.create(content: "你喜歡哪個歌手")
    Question.create(content: "你喜歡什麼運動")
    Question.create(content: "你討厭吃什麼")
    Question.create(content: "你常去旅遊嗎")
    Question.create(content: "你有養寵物嗎")

    puts "建立地區"
    l1 = Location.create(name: "臺北市")
    l2 = Location.create(name: "新北市")
    l3 = Location.create(name: "桃園市")
    l4 = Location.create(name: "臺中市")
    l5 = Location.create(name: "臺南市")
    l6 = Location.create(name: "高雄市")
    l7 = Location.create(name: "基隆市")
    l8 = Location.create(name: "新竹市")
    l9 = Location.create(name: "嘉義市")
    l10 = Location.create(name: "新竹縣")
    l11 = Location.create(name: "苗栗縣")
    l12 = Location.create(name: "彰化縣")
    l13 = Location.create(name: "南投縣")
    l14 = Location.create(name: "雲林縣")
    l15 = Location.create(name: "嘉義縣")
    l16 = Location.create(name: "屏東縣")
    l17 = Location.create(name: "宜蘭縣")
    l18 = Location.create(name: "花蓮縣")
    l19 = Location.create(name: "臺東縣")
    l20 = Location.create(name: "澎湖縣")

    puts "建立Avatar"
    Avatar.create(filename: 'A1.jpg')
    Avatar.create(filename: 'A2.jpg')
    Avatar.create(filename: 'A3.jpg')
    Avatar.create(filename: 'A4.jpg')
    Avatar.create(filename: 'A5.jpg')
    Avatar.create(filename: 'A6.jpg')

    puts "建立使用者 & 個人資料"
    user1 = User.create!(:email => "yakushou730@gmail.com", :password => "000000")
    profile1 = Profile.create!(:nickname => "鶯歌吳彥祖", :user_id => user1.id,
                          :age => 29,
                          :sex => "男",
                          :relation => "單身",
                          :description => "逆風的方向，更適合飛翔",
                          :aboutme => "開心過生活",
                          :facebook_link => "https://www.facebook.com/yakushou730",
                          :facebook_access_level => 20,
                          :line_account => "yakushou730",
                          :line_access_level => 20,
                          :wechat_account => "yakushou730",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user2 = User.create!(:email => "gutianlou@gmail.com", :password => "000000")
    profile2 = Profile.create!(:nickname => "板橋古天樂", :user_id => user2.id,
                          :age => 35,
                          :sex => "男",
                          :relation => "已婚",
                          :description => "永遠等待那一日咱可以出頭天，人生不怕風浪只怕自己沒志氣",
                          :aboutme => "和平過生活",
                          :facebook_link => "https://www.facebook.com/GuTianLou",
                          :facebook_access_level => 20,
                          :line_account => "GuTianLou",
                          :line_access_level => 20,
                          :wechat_account => "GuTianLou",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user3 = User.create!(:email => "fondisou@gmail.com", :password => "000000")
    profile3 = Profile.create!(:nickname => "大安馮迪索", :user_id => user3.id,
                          :age => 18,
                          :sex => "男",
                          :relation => "單身",
                          :description => "當你的愛已碎，以為純真會幻滅，其實等在前面、還有一整個世界，新的視野、新的起點",
                          :aboutme => "安心過生活",
                          :facebook_link => "https://www.facebook.com/FonDiSou",
                          :facebook_access_level => 20,
                          :line_account => "FonDiSou",
                          :line_access_level => 20,
                          :wechat_account => "FonDiSou",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user4 = User.create!(:email => "suenciechie@gmail.com", :password => "000000")
    profile4 = Profile.create!(:nickname => "安和路孫協志", :user_id => user4.id,
                          :age => 18,
                          :sex => "男",
                          :relation => "單身",
                          :description => "那陽光碎裂在熟悉場景，好安靜、一個人能背多少的往事，真不輕",
                          :aboutme => "安心過生活",
                          :facebook_link => "https://www.facebook.com/SuenCieChie",
                          :facebook_access_level => 20,
                          :line_account => "SuenCieChie",
                          :line_access_level => 20,
                          :wechat_account => "SuenCieChie",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user5 = User.create!(:email => "chenishin@gmail.com", :password => "000000")
    profile5 = Profile.create!(:nickname => "公館陳奕迅", :user_id => user5.id,
                          :age => 18,
                          :sex => "男",
                          :relation => "單身",
                          :description => "那陽光碎裂在熟悉場景，好安靜、一個人能背多少的往事，真不輕",
                          :aboutme => "安心過生活",
                          :facebook_link => "https://www.facebook.com/ChenIShin",
                          :facebook_access_level => 20,
                          :line_account => "ChenIShin",
                          :line_access_level => 20,
                          :wechat_account => "ChenIShin",
                          :wechat_access_level => 20,
                          :location_id => l1.id)




    user51 = User.create!(:email => "ancinya@gmail.com", :password => "000000")
    profile51 = Profile.create!(:nickname => "平溪安心亞", :user_id => user51.id,
                          :age => 18,
                          :sex => "女",
                          :relation => "單身",
                          :description => "就算整個世界把我拋棄，而至少快樂傷心我自​​己決定",
                          :aboutme => "快樂過生活",
                          :facebook_link => "https://www.facebook.com/AnCinYia",
                          :facebook_access_level => 20,
                          :line_account => "AnCinYia",
                          :line_access_level => 20,
                          :wechat_account => "AnCinYa",
                          :wechat_access_level => 20,
                          :location_id => l2.id)



    user52 = User.create!(:email => "kuotsiachieh@gmail.com", :password => "000000")
    profile52 = Profile.create!(:nickname => "松江南京郭采潔", :user_id => user52.id,
                          :age => 18,
                          :sex => "女",
                          :relation => "單身",
                          :description => "當你的心已累，以為失去了一切，其實等在前面還有一整個世界",
                          :aboutme => "和平過生活",
                          :facebook_link => "https://www.facebook.com/KuoTsaiChieh",
                          :facebook_access_level => 20,
                          :line_account => "KuoTsaiChieh",
                          :line_access_level => 20,
                          :wechat_account => "KuoTsaiChieh",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user53 = User.create!(:email => "kuoshefu@gmail.com", :password => "000000")
    profile53 = Profile.create!(:nickname => "信義郭雪芙", :user_id => user53.id,
                          :age => 20,
                          :sex => "女",
                          :relation => "單身",
                          :description => "當風雨都過去迎著風看天空，不放棄才能夠有感動",
                          :aboutme => "勇敢過生活",
                          :facebook_link => "https://www.facebook.com/KuoSheFu",
                          :facebook_access_level => 20,
                          :line_account => "KuoSheFu",
                          :line_access_level => 20,
                          :wechat_account => "KuoSheFu",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user54 = User.create!(:email => "linchilin@gmail.com", :password => "000000")
    profile54 = Profile.create!(:nickname => "北車林志玲", :user_id => user54.id,
                          :age => 20,
                          :sex => "女",
                          :relation => "單身",
                          :description => "這一生這一次為自己抬起頭，至少要驕傲的盛開過",
                          :aboutme => "驕傲過生活",
                          :facebook_link => "https://www.facebook.com/LinChiLin",
                          :facebook_access_level => 20,
                          :line_account => "LinChiLin",
                          :line_access_level => 20,
                          :wechat_account => "LinChiLin",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user55 = User.create!(:email => "jansauhan@gmail.com", :password => "000000")
    profile55 = Profile.create!(:nickname => "景美張韶涵", :user_id => user55.id,
                          :age => 20,
                          :sex => "女",
                          :relation => "單身",
                          :description => "我不好也不壞不特別出眾，我只是敢不同",
                          :aboutme => "欣然過生活",
                          :facebook_link => "https://www.facebook.com/JanSauHan",
                          :facebook_access_level => 20,
                          :line_account => "JanSauHan",
                          :line_access_level => 20,
                          :wechat_account => "JanSauHan",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user56 = User.create!(:email => "suetan@gmail.com", :password => "000000")
    profile56 = Profile.create!(:nickname => "大安隋棠", :user_id => user56.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "我的人生就是一錯再錯，錯完了再從頭",
                          :aboutme => "幸福過生活",
                          :facebook_link => "https://www.facebook.com/SueTan",
                          :facebook_access_level => 20,
                          :line_account => "SueTan",
                          :line_access_level => 20,
                          :wechat_account => "SueTan",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user57 = User.create!(:email => "bechanjinzi@gmail.com", :password => "000000")
    profile57 = Profile.create!(:nickname => "六張犁北川景子", :user_id => user57.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "就放肆愛放肆追、放肆去闖、放肆是我的信仰",
                          :aboutme => "漫步過生活",
                          :facebook_link => "https://www.facebook.com/BeChanJinZi",
                          :facebook_access_level => 20,
                          :line_account => "BeChanJinZi",
                          :line_access_level => 20,
                          :wechat_account => "BeChanJinZi",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user58 = User.create!(:email => "jiajinwen@gmail.com", :password => "000000")
    profile58 = Profile.create!(:nickname => "龍山寺賈靜雯", :user_id => user58.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "每一個險惡的浪，都會有浪花綻放，我決定邊衝邊欣賞",
                          :aboutme => "文青過生活",
                          :facebook_link => "https://www.facebook.com/JiaJinWen",
                          :facebook_access_level => 20,
                          :line_account => "JiaJinWen",
                          :line_access_level => 20,
                          :wechat_account => "JiaJinWen",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user59 = User.create!(:email => "linichen@gmail.com", :password => "000000")
    profile59 = Profile.create!(:nickname => "木柵林依晨", :user_id => user59.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "夢想永遠是逆向，一路都有人阻擋，人們說的荒唐、卻是我的心中的天堂",
                          :aboutme => "美妙過生活",
                          :facebook_link => "https://www.facebook.com/LinIChen",
                          :facebook_access_level => 20,
                          :line_account => "LinIChen",
                          :line_access_level => 20,
                          :wechat_account => "LinIChen",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user60 = User.create!(:email => "suenjianzi@gmail.com", :password => "000000")
    profile60 = Profile.create!(:nickname => "板南線孫燕姿", :user_id => user60.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "我不是好子，我不是歹人，我只是愛眠夢",
                          :aboutme => "奇幻過生活",
                          :facebook_link => "https://www.facebook.com/SuenJianZi",
                          :facebook_access_level => 20,
                          :line_account => "SuenJianZi",
                          :line_access_level => 20,
                          :wechat_account => "SuenJianZi",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user61 = User.create!(:email => "jipaime@gmail.com", :password => "000000")
    profile61 = Profile.create!(:nickname => "淡水雞排妹", :user_id => user61.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "想要征服的世界，始終都沒有改變，那地上無聲蒸發我的淚",
                          :aboutme => "認真過生活",
                          :facebook_link => "https://www.facebook.com/JiPaiMe",
                          :facebook_access_level => 20,
                          :line_account => "JiPaiMe",
                          :line_access_level => 20,
                          :wechat_account => "JiPaiMe",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user62 = User.create!(:email => "chenchiaan@gmail.com", :password => "000000")
    profile62 = Profile.create!(:nickname => "土城陳喬恩", :user_id => user62.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "經過了漫長的等候，夢想是夢想，我還是一個我",
                          :aboutme => "歡喜過生活",
                          :facebook_link => "https://www.facebook.com/ChenChiaAn",
                          :facebook_access_level => 20,
                          :line_account => "ChenChiaAn",
                          :line_access_level => 20,
                          :wechat_account => "ChenChiaAn",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user63 = User.create!(:email => "tsaiilin@gmail.com", :password => "000000")
    profile63 = Profile.create!(:nickname => "永和蔡依林", :user_id => user63.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "如果說了後悔，是不是一切就能倒退，回憶多麼美，活著多麼狼狽",
                          :aboutme => "喜悅過生活",
                          :facebook_link => "https://www.facebook.com/TsaiILin",
                          :facebook_access_level => 20,
                          :line_account => "TsaiILin",
                          :line_access_level => 20,
                          :wechat_account => "TsaiILin",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user64 = User.create!(:email => "tianfujian@gmail.com", :password => "000000")
    profile64 = Profile.create!(:nickname => "泰山田馥甄", :user_id => user64.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "有沒有那麼一個明天，重頭活一遍",
                          :aboutme => "用心過生活",
                          :facebook_link => "https://www.facebook.com/TianFuJian",
                          :facebook_access_level => 20,
                          :line_account => "TianFuJian",
                          :line_access_level => 20,
                          :wechat_account => "TianFuJian",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user65 = User.create!(:email => "cieginian@gmail.com", :password => "000000")
    profile65 = Profile.create!(:nickname => "新莊謝金燕", :user_id => user65.id,
                          :age => 24,
                          :sex => "女",
                          :relation => "單身",
                          :description => "有沒有那麼一張書籤，停止那一天，最單純的笑臉和最美那一年",
                          :aboutme => "舒服過生活",
                          :facebook_link => "https://www.facebook.com/CieGinIan",
                          :facebook_access_level => 20,
                          :line_account => "CieGinIan",
                          :line_access_level => 20,
                          :wechat_account => "CieGinIan",
                          :wechat_access_level => 20,
                          :location_id => l2.id)





=begin
    5.times do
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile.id,
                     content: Faker::Lorem.sentence)
    end

    HobbyTag.create!(profile_id: profile.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
    ProfessionTag.create!(profile_id: profile.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))



    10.times do |i|
      u = User.create!(:email =>  Faker::Internet.email, :password => "000000")
      p = Profile.create!(:nickname => Faker::Name.name,
                          :user_id => u.id,
                          :age => Faker::Number.between(18, 30),
                          :sex => sex_array[Faker::Number.between(0,1)],
                          :relation => relation_array[Faker::Number.between(0,2)],
                          :description => Faker::Lorem.sentence,
                          :aboutme => Faker::Lorem.sentence,
                          :facebook_link => Faker::Internet.url('facebook.com'),
                          :facebook_access_level => Faker::Number.between(0, 100),
                          :line_account => Faker::Name.name,
                          :line_access_level => Faker::Number.between(0, 100),
                          :wechat_account => Faker::Name.name,
                          :wechat_access_level => Faker::Number.between(0, 100),
                          :location_id => Faker::Number.between(Location.first.id, Location.last.id))

      5.times do
        Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                       profile_id: p.id,
                       content: Faker::Lorem.sentence)
      end

      HobbyTag.create!(profile_id: p.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      ProfessionTag.create!(profile_id: p.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))



    end
=end

  end

end