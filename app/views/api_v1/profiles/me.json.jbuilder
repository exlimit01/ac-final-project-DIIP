json.set! :code, '200'
json.set! :result, 'success'
json.set! :data do
  json.set! :nickname, @profile.nickname
  json.set! :age, @profile.age
  json.set! :sex, @profile.sex
  json.set! :relation, @profile.relation
  json.set! :location, @profile.location.name
  json.set! :aboutme, @profile.aboutme

  json.set! :photos, @photos
  json.set! :hobbies, @hobbies

end

=begin

範例

{
  code: "200",
  result: "success",
  data: {
    nickname: "Yao-Shang",
    age: 18,
    sex: "男",
    relation: "未婚",
    location: "臺北市",
    aboutme: "手牽手一步兩步三步四步望著天",
    photos: [
      {
        url: "http://localhost:3000//system/photos/photos/000/000/005/medium/imgres-1.png?1468760065"
      },
      {
        url: "http://localhost:3000//system/photos/photos/000/000/006/medium/imgres-2.png?1468760065"
      },
      {
        url: "http://localhost:3000//system/photos/photos/000/000/007/medium/imgres-3.png?1468760065"
      },
      {
        url: "http://localhost:3000//system/photos/photos/000/000/008/medium/imgres-4.png?1468760065"
      }
    ],
    hobbies: [
      {
        name: "籃球"
      },
      {
        name: "游泳"
      },
      {
        name: "旅遊"
      },
      {
        name: "聽音樂"
      },
      {
        name: "逛街"
      }
    ]
  }
}

=end