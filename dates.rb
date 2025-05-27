require 'tzinfo'

puts "Hi! Please, enter timezone you want to see:"
wanted_zone = gets.chomp

def time_converter(wanted_zone, current_time = Time.now.utc)
    identifiers_origin = TZInfo::Timezone.all_identifiers
    if identifiers_origin.find_index("#{wanted_zone}") != nil
        user_time_zone = TZInfo::Timezone.get(wanted_zone)
        user_time_zone.utc_to_local(current_time)
        else return "Wrong timezone!"
    end
end

user_time = time_converter(wanted_zone)

puts "Okay, your time is #{user_time}"
