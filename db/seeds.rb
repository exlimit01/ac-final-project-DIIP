# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroy all data"
User.destroy_all
Hobby.destroy_all
Profession.destroy_all
Mission.destroy_all
Question.destroy_all
Location.destroy_all

puts "Create User fake data"
User.create({:email => "aaa@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "bbb@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "ccc@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "ddd@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "eee@gmail.com", :password => "000000", :password_confirmation => "000000" })

puts "Create Hobby fake data"
Hobby.create(name: "籃球")
Hobby.create(name: "游泳")
Hobby.create(name: "旅遊")
Hobby.create(name: "聽音樂")
Hobby.create(name: "逛街")

puts "Create Profession fake data"
Profession.create(name: "科技")
Profession.create(name: "金融")
Profession.create(name: "醫療")
Profession.create(name: "服務")
Profession.create(name: "教育")

puts "Create Mission fake data"
Mission.create(content: "一起去看電影")
Mission.create(content: "一起去唱歌")
Mission.create(content: "一起去郊遊")
Mission.create(content: "一起去健身房")
Mission.create(content: "一起去爬山")

puts "Create Question fake data"
Question.create(content: "你喜歡哪個歌手")
Question.create(content: "你喜歡什麼運動")
Question.create(content: "你討厭吃什麼")
Question.create(content: "你常去旅遊嗎")
Question.create(content: "你有養寵物嗎")

puts "Create Location fake data"
Location.create(name: "臺北市")
Location.create(name: "新北市")
Location.create(name: "桃園市")
Location.create(name: "臺中市")
Location.create(name: "臺南市")
Location.create(name: "高雄市")
Location.create(name: "基隆市")
Location.create(name: "新竹市")
Location.create(name: "嘉義市")
Location.create(name: "新竹縣")
Location.create(name: "苗栗縣")
Location.create(name: "彰化縣")
Location.create(name: "南投縣")
Location.create(name: "雲林縣")
Location.create(name: "嘉義縣")
Location.create(name: "屏東縣")
Location.create(name: "宜蘭縣")
Location.create(name: "花蓮縣")
Location.create(name: "臺東縣")
Location.create(name: "澎湖縣")



