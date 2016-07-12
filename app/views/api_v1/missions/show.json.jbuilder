#json.partial! 'details', mission: @mission
#json.id @mission.id
#json.content @mission.content
#json.unlock_level @mission.unlock_level
#json.popular @mission.popular
#json.created_at @mission.created_at
#json.updated_at @mission.updated_at

json.set! :code, '200'
json.set! :result, 'success'
json.set! :data do
  json.set! :mission, @mission
end