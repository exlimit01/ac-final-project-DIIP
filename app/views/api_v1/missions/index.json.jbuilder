#json.mission do
  #json.missions @missions.each do |m|
    #json.id m.id
    #json.content m.content
    #json.unlock_level m.unlock_level
    #json.popular m.popular
    #json.created_at m.created_at
    #json.updated_at m.updated_at
    #json.partial! 'details', mission: m
  #end
#end

#json.array! @missions

#json.missions @missions


json.set! :code, '200'
json.set! :result, 'success'
json.set! :data do
  json.set! :missions, @missions
end