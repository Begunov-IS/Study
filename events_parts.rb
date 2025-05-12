class Event
  attr_accessor :name, :place, :seats_number, :participants
  def initialize(name, place, seats_number, participants=[])
    @name = name
    @place = place
    @seats_number = seats_number
    @participants = participants
  end

  def add_participant(participant)
    
    participants.push(participant)
  end
  
  def remove_participant(email='', name='')
    email = email.downcase
    @participants.map do |participant|
        if !email.include? "@"
          puts "Entered wrong email!"
        elsif participant[:email] == "#{email}"
            @participants.delete(participant)
        end
    end
  end
end


unless defined?(user_id)
  user_id = rand(1000...9999)
end

unless defined?(events_array)
  events_array = []
end

loop do
  puts "Hi! Enter one of commands:\n1. Add_event\n2. Add_participant\n3. Remove_participant\n4. Show_participants\n5. Exit"

  user_input = gets.chomp.downcase

  puts "You entered: #{user_input}"

  case user_input

  when "1", "add_event"
    puts "Okay, now I will ask you some questions about your event:\n 1. What is your event name?"
    event_name = gets.chomp.capitalize

    puts "You entered: #{event_name}.\n2. Please, write the place your event will be:"
    event_place = gets.chomp.capitalize

    puts "You entered: #{event_place}.\n3. Please, write the number of seats of your event:"
    event_seats = gets.chomp
    while event_seats.to_i == 0
      puts "You entered wrong number: #{event_seats}\nPlease, enter only number, without any another symbols"
      event_seats = gets.chomp.strip
    end

    puts "You entered: #{event_seats}.\n4. You can also enter participants for your event, do you want to do it now? [Yes/No]"
    participant_choice = gets.chomp.downcase
    unless defined?(event_participants)
      event_participants = []
    end
    while participant_choice == "yes"
      participant_approve = ""
      until participant_approve == "yes" || participant_approve == "exit"
      puts "Well, enter Name, Sername and Email of participant. Please divide it with one gap:"
      event_participant = gets.chomp.split
      puts "You entered:\nName: #{event_participant[0]}\nSername: #{event_participant[1]}\nEmail: #{event_participant[2]}\n - is it true?[yes/no]"
      participant_approve = gets.chomp.downcase
      end
      if participant_approve == "yes"
      event_participants.push({name: "#{event_participant[0]}", sername: "#{event_participant[1]}", email: "#{event_participant[2]}"})
      puts "Массив участников: #{event_participants}"
      end
      puts "Do you want to add another participant? [yes/no]"
      participant_choice = gets.chomp.downcase
    end

    puts "So, your event name: #{event_name}\nEvent place: #{event_place}\nEvent seats: #{event_seats}\nEvent participants: #{event_participants}\n - is it true?[yes/no]"
    event_approve = gets.chomp.downcase
    if event_approve == "yes"
      new_event = Event.new("#{event_name}", "#{event_place}", "#{event_seats}", event_participants)
      instance_variable_set("@#{event_name}_userid#{user_id}", new_event)
      puts "Okay, new event is added:\n#{new_event}" 
    end
  end

when "2", "add_participant"
  puts "Okay, please, tell the name of event for participants you want to add:"
  wanted_event_name = gets.chomp.capitalize
  loop do #тут цикл ввода начинает ДОПИСАТЬ!!!

    if instance_variable_defined?("@#{wanted_event_name}_userid#{user_id}")
      wnated_event = instance_variable_get("@#{wanted_event_name}_userid#{user_id}")
      puts "Okay, here is info about your event:\nName: #{wnated_event.name}\nPlace: #{wnated_event.name}\nSeats: #{wnated_event.seats_number}\nParticipants: #{wnated_event.participants}"
      puts "Do you wnat to add participants for your event? [Yes/No]"
      participant_choice = gets.chomp.downcase
      unless defined?(event_participants)
        event_participants = []
      end
      while participant_choice == "yes"
        participant_approve = ""
        until participant_approve == "yes" || participant_approve == "exit"
        puts "Well, enter Name, Sername and Email of participant. Please divide it with one gap:"
        event_participant = gets.chomp.split
        puts "You entered:\nName: #{event_participant[0]}\nSername: #{event_participant[1]}\nEmail: #{event_participant[2]}\n - is it true?[yes/no]"
        participant_approve = gets.chomp.downcase
        end
        if participant_approve == "yes"
        event_participants.push({name: "#{event_participant[0]}", sername: "#{event_participant[1]}", email: "#{event_participant[2]}"})
        puts "Массив участников: #{event_participants}"
        end
        puts "Do you want to add another participant? [yes/no]"
        participant_choice = gets.chomp.downcase
      end
    else puts "I can't find the event you want. Please try to enter the name of your event again:"
#тут цикл ввода заканчивается

  end
  break if user_input == "exit" || user_input == "Exit"
end
