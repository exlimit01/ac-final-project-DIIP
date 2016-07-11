json.custom_missions @missions do |m|
  json.partial! 'details', mission: m
end