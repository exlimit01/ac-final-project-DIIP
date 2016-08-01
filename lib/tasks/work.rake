namespace :work do

  task :force_give_matching_mission => :environment do

    Friendship.destroy_all

    f_aaa = User.find_by_email("yakushou730@gmail.com")
    f_bbb = User.find_by_email("bbb@gmail.com")
    f_ccc = User.find_by_email("ccc@gmail.com")

    m_matching = Mission.find_by(:unlock_level => -1)
    m_go_out = Mission.find_by(:unlock_level => -2)

    #f_ab = Friendship.create(:user_id => f_aaa.id, :friend_id => f_bbb.id, :love_level => 0)
    #f_ba = Friendship.create(:user_id => f_bbb.id, :friend_id => f_aaa.id, :love_level => 0)
    f_ac = Friendship.create(:user_id => f_aaa.id, :friend_id => f_ccc.id, :love_level => 0)
    f_ca = Friendship.create(:user_id => f_ccc.id, :friend_id => f_aaa.id, :love_level => 20)
    f_bc = Friendship.create(:user_id => f_bbb.id, :friend_id => f_ccc.id, :love_level => 0)
    f_cb = Friendship.create(:user_id => f_ccc.id, :friend_id => f_bbb.id, :love_level => 80)

    f_ac.interactions.destroy_all
    f_ca.interactions.destroy_all
    #f_ab.interactions.destroy_all
    #f_ba.interactions.destroy_all

    f_ac.interactions.create!(:mission_id => m_matching.id, :co_status => 0)
    f_ca.interactions.create!(:mission_id => m_matching.id, :co_status => 0)

    10.times do
      m = Mission.all.sample
      f_bc_inters = f_bc.interactions.create!(:mission_id => m.id, :co_status => 8)
      f_cb_inters = f_cb.interactions.create!(:mission_id => m.id, :co_status => 8)
      r = Room.create(user_id1: f_bc.id, user_id2: f_cb.id, interaction_id1: f_bc_inters.id, interaction_id2: f_cb_inters.id, mission_id: m.id)
      f_bc_inters.room = r
      f_bc_inters.save
      f_cb_inters.room = r
      f_cb_inters.save
    end

    f_bc.interactions.create!(:mission_id => m_go_out.id, :co_status => 0)
    f_cb.interactions.create!(:mission_id => m_go_out.id, :co_status => 0)


  end

  # 模擬功能
  task :reset_simu_mission => :environment do

    Friendship.destroy_all

    f_aaa = User.find_by_email("yakushou730@gmail.com")
    f_bbb = User.find_by_email("bbb@gmail.com")
    f_ccc = User.find_by_email("ccc@gmail.com")

    m_matching = Mission.find_by(:unlock_level => -1)
    m_go_out = Mission.find_by(:unlock_level => -2)

    #f_ab = Friendship.create(:user_id => f_aaa.id, :friend_id => f_bbb.id, :love_level => 0)
    #f_ba = Friendship.create(:user_id => f_bbb.id, :friend_id => f_aaa.id, :love_level => 0)
    f_ac = Friendship.create(:user_id => f_aaa.id, :friend_id => f_ccc.id, :love_level => 0)
    f_ca = Friendship.create(:user_id => f_ccc.id, :friend_id => f_aaa.id, :love_level => 20)
    f_bc = Friendship.create(:user_id => f_bbb.id, :friend_id => f_ccc.id, :love_level => 0)
    f_cb = Friendship.create(:user_id => f_ccc.id, :friend_id => f_bbb.id, :love_level => 80)

    f_ac.interactions.destroy_all
    f_ca.interactions.destroy_all
    #f_ab.interactions.destroy_all
    #f_ba.interactions.destroy_all

    #f_ac.interactions.create!(:mission_id => m_matching.id, :co_status => 0)
    #f_ca.interactions.create!(:mission_id => m_matching.id, :co_status => 0)

    10.times do
      m = Mission.all.sample
      f_bc_inters = f_bc.interactions.create!(:mission_id => m.id, :co_status => 8)
      f_cb_inters = f_cb.interactions.create!(:mission_id => m.id, :co_status => 8)
      r = Room.create(user_id1: f_bc.id, user_id2: f_cb.id, interaction_id1: f_bc_inters.id, interaction_id2: f_cb_inters.id, mission_id: m.id)
      f_bc_inters.room = r
      f_bc_inters.save
      f_cb_inters.room = r
      f_cb_inters.save
    end

    f_bc.interactions.create!(:mission_id => m_go_out.id, :co_status => 0)
    f_cb.interactions.create!(:mission_id => m_go_out.id, :co_status => 0)

  end

  # 真的會用到的功能
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

  task :set_all => :environment do

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
    Hobby.create(name: "攝影")
    Hobby.create(name: "科技")
    Hobby.create(name: "設計")
    Hobby.create(name: "音樂")
    Hobby.create(name: "藝術")
    Hobby.create(name: "閱讀")
    Hobby.create(name: "美食")
    Hobby.create(name: "電影")
    Hobby.create(name: "單車")
    Hobby.create(name: "寫作")
    Hobby.create(name: "跑步")
    Hobby.create(name: "健身")
    Hobby.create(name: "咖啡")
    Hobby.create(name: "政治")
    Hobby.create(name: "登山")
    Hobby.create(name: "程式")
    Hobby.create(name: "手作")
    Hobby.create(name: "廚藝")
    Hobby.create(name: "舞蹈")
    Hobby.create(name: "瑜珈")
    Hobby.create(name: "繪畫")
    Hobby.create(name: "寵物")
    Hobby.create(name: "志工")
    Hobby.create(name: "動畫")
    Hobby.create(name: "流行")
    Hobby.create(name: "購物")
    Hobby.create(name: "運動")
    Hobby.create(name: "狗")
    Hobby.create(name: "貓")
    Hobby.create(name: "棒球")
    Hobby.create(name: "籃球")
    Hobby.create(name: "足球")
    Hobby.create(name: "品酒")
    Hobby.create(name: "甜點")
    Hobby.create(name: "遊戲")
    Hobby.create(name: "游泳")
    Hobby.create(name: "衝浪")
    Hobby.create(name: "唱歌")

    puts "建立專業"
    Profession.create(name: "學生")
    Profession.create(name: "專案管理")
    Profession.create(name: "軟體開發")
    Profession.create(name: "前端開發")
    Profession.create(name: "後端開發")

    Profession.create(name: "顧問服務")
    Profession.create(name: "設計師")
    Profession.create(name: "藝術家")
    Profession.create(name: "建築師")
    Profession.create(name: "老師")
    Profession.create(name: "護士")
    Profession.create(name: "作家")
    Profession.create(name: "編輯")
    Profession.create(name: "廚師")
    Profession.create(name: "攝影師")
    Profession.create(name: "爸爸")
    Profession.create(name: "媽媽")

    Profession.create(name: "表演藝術")
    Profession.create(name: "醫師")
    Profession.create(name: "心理學家")
    Profession.create(name: "創業者")
    Profession.create(name: "美髮師")
    Profession.create(name: "健身教練")
    Profession.create(name: "社群媒體")
    Profession.create(name: "演說家")
    Profession.create(name: "歌曲創作")

    puts "建立任務"
    Mission.create(content: "默契考驗", unlock_level: -1)
    Mission.create(content: "見面任務", unlock_level: -2)
    Mission.create(content: "說出對方目前最吸引自己的地方", unlock_level: 10)
    Mission.create(content: "連續三天在你睡覺前跟對方說晚安，以及在起床後跟對方說早安", unlock_level: 10)
    Mission.create(content: "找到對方三樣跟自己相同的喜好或興趣", unlock_level: 10)
    Mission.create(content: "在今天睡前寫下你今天一整天的日記", unlock_level: 10)
    Mission.create(content: "告訴對方你最近的煩惱，以及尋求對方的建議", unlock_level: 10)
    Mission.create(content: "告訴對方最近覺得最惱火的人以及原因", unlock_level: 10)
    Mission.create(content: "分享三間自己最喜歡的餐廳", unlock_level: 10)

    Mission.create(content: "錄下自己最拿手的歌給對方聽", unlock_level: 31)
    Mission.create(content: "告訴對方，你已經開始喜歡他的某些特質", unlock_level: 31)
    Mission.create(content: "告訴對方有沒有什麼事情是我夢寐以求想做的？為何我沒有做這件事？", unlock_level: 31)
    Mission.create(content: "分享一個你的私人困擾，並請你的夥伴給你一些建議", unlock_level: 31)
    Mission.create(content: "如果你覺得能和你對面的夥伴成為親密的朋友，請跟他分享身為親密朋友該知道的事", unlock_level: 31)
    Mission.create(content: "輪流分享到目前為止，你覺得對面夥伴的三個正向特質", unlock_level: 31)
    Mission.create(content: "花四分鐘時間告訴對方你的人生故事，越詳細越好。", unlock_level: 31)
    Mission.create(content: "和對方分享你人生中最尷尬的片刻", unlock_level: 31)
    Mission.create(content: "告訴對方你到目前為主，對對方分享的事情感到最印象深刻的事情", unlock_level: 31)
    Mission.create(content: "告訴上一次在別人面前哭泣是什麼時候？還是通常自己一個人哭泣？", unlock_level: 31)

    Mission.create(content: "一起參加近期的活動或展覽", unlock_level: 61)
    Mission.create(content: "一起看電影", unlock_level: 61)
    Mission.create(content: "一起吃飯", unlock_level: 61)
    Mission.create(content: "幫對方挑一件適合它的服飾", unlock_level: 61)
    Mission.create(content: "陪對方一起剪頭髮並給出自己的建議", unlock_level: 61)
    Mission.create(content: "跟對方說一件你還沒跟別人說過的事情", unlock_level: 61)
    Mission.create(content: "誠實的告訴對方，你最喜歡他的地方", unlock_level: 61)

    Mission.create(content: "詢問對方如果兩個人在一起，有哪些事情是對方最不能忍受的事情", unlock_level: 81)
    Mission.create(content: "詢問對方如果兩個人在一起，是否能夠接受不帶對方，自己去做一些事情", unlock_level: 81)
    Mission.create(content: "邀請對方一起發掘當地最美的風景", unlock_level: 81)
    Mission.create(content: "傳一張你還沒有給別人看到的自拍給對方", unlock_level: 81)
    Mission.create(content: "嘗試與對方手牽手15分鐘不放開", unlock_level: 81)
    Mission.create(content: "嘗試跟對方撒嬌，並上傳音檔給對方", unlock_level: 81)

    puts "建立問題"
    Question.create(content: "完成以下這個句子：「我希望有人能與我共享...，因為...」")
    Question.create(content: "對於我而言，哪些事情開不得玩笑？")
    Question.create(content: "如果我今晚就會死去，死去前沒有機會再與任何人溝通，我會最後悔沒和誰說什麼話？為什麼這些話我不及早跟他說？")
    Question.create(content: "我的房子著火了，裡頭有所有我愛的東西，我只有幾分鐘的時間可以救出一個東西，我會選擇救什麼？")
    Question.create(content: "我希望自己出名嗎？希望自己以什麼方式出名？")
    Question.create(content: "再打電話之前，我是否曾經預演過自己要說什麼？為什麼？")
    Question.create(content: "對於我來說，一個「完美」的一天必須具備什麼元素？")
    Question.create(content: "我上一次唱歌給自己聽是什麼時候？上一次唱給別人聽呢？")
    Question.create(content: "如果我能夠活到九十歲，而且能選擇保有三十歲的身體或三十歲的心靈活力，我會選擇保有哪個？")
    Question.create(content: "你對於自己將如何死去，是否曾有過神秘的預感？")
    Question.create(content: "我在目前人生中最感激的事情是什麼？")
    Question.create(content: "如果我能改變你成長過程中的任何一件事，我會想改變什麼？")
    Question.create(content: "如果我明天一早醒來，可以增加一個技能或能力，我希望是什麼？")
    Question.create(content: "如果有一個水晶球可以告訴我關於自己的所有事、我的人生或我的未來，我最想知道什麼是？")
    Question.create(content: "我目前人生最大的成就是什麼？")
    Question.create(content: "在友情中，我最重視的事情是什麼？")
    Question.create(content: "我目前人生中最珍惜的是哪一段回憶？")
    Question.create(content: "我目前人生中最糟糕的是哪一段回憶？")
    Question.create(content: "如果我知道一年後你會死掉，我會想改變現在你的生活方式嗎？為什麼？")
    Question.create(content: "友情對於我的意義是什麼？")
    Question.create(content: "愛情以及喜歡在我人生中扮演著什麼樣的角色？")
    Question.create(content: "我會覺得自己比其他家庭的孩子更幸福嗎？")
    Question.create(content: "我覺得自己與媽媽的關係如何？我跟另一半一起出去玩的時候，通常是各付各的還是由我來付，為什麼？")
    Question.create(content: "我在今年最想要達到的目標是什麼？")
    Question.create(content: "我曾經將時間及精力花在哪些對我其實不那麼重要的事情上？")
    Question.create(content: "做哪件事情最能讓我感到具有意義？為什麼？")
    Question.create(content: "做哪件事情最能讓我感到快樂？為什麼？")
    Question.create(content: "我的家人意見不同時，是會大聲爭執、平靜討論還是冷戰？")
    Question.create(content: "我談過最久的一次戀愛是多久？為什麼最後分開？")
    Question.create(content: "我曾經最瘋狂的經驗是什麼？")
    Question.create(content: "有哪三件事情是我絕對不會去做的？")
    Question.create(content: "我做過最浪漫的一件事情是什麼？")
    Question.create(content: "我目前最喜歡的一位歌手，為什麼？")
    Question.create(content: "我目前最喜歡的三部電影，為什麼？")
    Question.create(content: "如果我樂透中獎得到一億獎金，會怎麼花這筆錢？")
    Question.create(content: "家族裡的所有成員哪個人死去，你會最傷心？為什麼？")

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
    profile1 = Profile.create!(:nickname => "匿名毛怪", :user_id => user1.id,
                          :age => 29,
                          :sex => "男",
                          :relation => "單身",
                          :description => "逆風的方向，更適合飛翔",
                          :aboutme => "開心過生活",
                          :facebook_link => "https://www.facebook.com/aaa",
                          :facebook_access_level => 20,
                          :line_account => "aaa",
                          :line_access_level => 20,
                          :wechat_account => "aaa",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user2 = User.create!(:email => "bbb@gmail.com", :password => "000000")
    profile2 = Profile.create!(:nickname => "匿名犀牛", :user_id => user2.id,
                          :age => 35,
                          :sex => "男",
                          :relation => "已婚",
                          :description => "永遠等待那一日咱可以出頭天，人生不怕風浪只怕自己沒志氣",
                          :aboutme => "和平過生活",
                          :facebook_link => "https://www.facebook.com/bbb",
                          :facebook_access_level => 20,
                          :line_account => "bbb",
                          :line_access_level => 20,
                          :wechat_account => "bbb",
                          :wechat_access_level => 20,
                          :location_id => l2.id)

    user3 = User.create!(:email => "ccc@gmail.com", :password => "000000")
    profile3 = Profile.create!(:nickname => "匿名皮卡丘", :user_id => user3.id,
                          :age => 18,
                          :sex => "女",
                          :relation => "單身",
                          :description => "當你的愛已碎，以為純真會幻滅，其實等在前面、還有一整個世界，新的視野、新的起點",
                          :aboutme => "安心過生活",
                          :facebook_link => "https://www.facebook.com/ccc",
                          :facebook_access_level => 20,
                          :line_account => "ccc",
                          :line_access_level => 20,
                          :wechat_account => "ccc",
                          :wechat_access_level => 20,
                          :location_id => l1.id)

    user4 = User.create!(:email => "suenciechie@gmail.com", :password => "000000")
    profile4 = Profile.create!(:nickname => "匿名狐狸", :user_id => user4.id,
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
    profile5 = Profile.create!(:nickname => "匿名獨角獸", :user_id => user5.id,
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
    profile51 = Profile.create!(:nickname => "匿名大眼仔", :user_id => user51.id,
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
    profile52 = Profile.create!(:nickname => "匿名哈士奇", :user_id => user52.id,
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
    profile53 = Profile.create!(:nickname => "匿名圓仔", :user_id => user53.id,
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
    profile54 = Profile.create!(:nickname => "匿名綿羊", :user_id => user54.id,
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
    profile55 = Profile.create!(:nickname => "匿名粉紅豬", :user_id => user55.id,
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
    profile56 = Profile.create!(:nickname => "匿名牧羊犬", :user_id => user56.id,
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
    profile57 = Profile.create!(:nickname => "匿名跳跳虎", :user_id => user57.id,
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
    profile58 = Profile.create!(:nickname => "匿名獅子王", :user_id => user58.id,
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
    profile59 = Profile.create!(:nickname => "匿名浣熊", :user_id => user59.id,
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
    profile60 = Profile.create!(:nickname => "匿名土撥鼠", :user_id => user60.id,
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


    5.times do

      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile1.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile2.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile3.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile4.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile5.id,
                     content: Faker::Lorem.sentence)

      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile51.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile52.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile53.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile54.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile55.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile56.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile57.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile58.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile59.id,
                     content: Faker::Lorem.sentence)
      Answer.create!(question_id: Faker::Number.between(Question.first.id, Question.last.id),
                     profile_id: profile60.id,
                     content: Faker::Lorem.sentence)
    end

    3.times do

      HobbyTag.create!(profile_id: profile1.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile2.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile3.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile4.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile5.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile51.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile52.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile53.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile54.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile55.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile56.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile57.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile58.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile59.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))
      HobbyTag.create!(profile_id: profile60.id,
                       hobby_id: Faker::Number.between(Hobby.first.id, Hobby.last.id))

    end

    ProfessionTag.create!(profile_id: profile1.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile2.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile3.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile4.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile5.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile51.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile52.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile53.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile54.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile55.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile56.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile57.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile58.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile59.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))
    ProfessionTag.create!(profile_id: profile60.id,
                       profession_id: Faker::Number.between(Profession.first.id, Profession.last.id))



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