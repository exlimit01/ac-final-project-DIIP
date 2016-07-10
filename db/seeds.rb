# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Hobby.destroy_all
Profession.destroy_all
Mission.destroy_all
Question.destroy_all

User.create({:email => "aaa@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "bbb@gmail.com", :password => "000000", :password_confirmation => "000000" })
User.create({:email => "ccc@gmail.com", :password => "000000", :password_confirmation => "000000" })

Hobby.create(name: "籃球")
Hobby.create(name: "游泳")
Hobby.create(name: "旅遊")
Hobby.create(name: "聽音樂")
Hobby.create(name: "逛街")

Profession.create(name: "科技")
Profession.create(name: "金融")
Profession.create(name: "醫療")
Profession.create(name: "服務")
Profession.create(name: "教育")

Mission.create(content: "一起看電影")
Mission.create(content: "一起看唱歌")
Mission.create(content: "一起看郊遊")
Mission.create(content: "一起去健身房")
Mission.create(content: "一起去爬山")

Question.create(content: "你喜歡哪個歌手")
Question.create(content: "你喜歡什麼運動")
Question.create(content: "你討厭吃什麼")
Question.create(content: "你常去旅遊嗎")
Question.create(content: "你有養寵物嗎")