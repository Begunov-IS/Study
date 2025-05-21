require 'tzinfo'

identifiers_origin = TZInfo::Timezone.all_identifiers
# Africa/Abidjan Africa/Accra America/New_York

#identifiers = identifiers_origin.map {|el| el.tr("/", ", ")}
#puts "#{identifiers}"
#puts identifiers

#identifiers_countries = identifiers.map do |el| 
#    res = el.scan(/\w+,/).map {|s| s.chomp(",")}
#end
#puts "#{identifiers_countries}"

current_time = Time.now.utc
puts "Hi! Now is #{current_time}, please, enter timezone you want to see:"
wanted_zone = gets.chomp

puts ".#{wanted_zone}."
user_time_zone = TZInfo::Timezone.get(wanted_zone)
user_time = user_time_zone.utc_to_local(current_time)
puts "Okay, your time is #{user_time}"
