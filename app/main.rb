require_relative 'models/legislator'

### print legislators by state ###

def all_legislators_from(state_abbr)
  ['Sen','Rep'].each do |title|
    puts party = title == 'Sen' ? 'Senators' : 'Representatives'
    legislators = Legislator.where("state = ? and title = ?", state_abbr, title)
    legislators.each do |rep| 
      puts "  #{rep.firstname} #{rep.lastname} (#{rep.party})"
    end
  end
end

### print out legislator gender ratios ###

def legislator_ratios
  ['Sen','Rep'].each do |title|
    party = title == 'Sen' ? 'Senators' : 'Representatives'
    ['M','F'].each do |gender|
      gen_count = Legislator.where("gender = ? and title = ?", gender, title).length
      total_count= Legislator.where("title = ?", title).length
      gen_ratio = ((gen_count.to_f/total_count)*100).to_i
      puts "#{gender} #{party}: #{gen_count} (#{gen_ratio}%)"
    end
  end
end

### print out active legislators by state ###

def legislator_count_from(state_abbr)
  output = "#{state_abbr}: " 
  ['Sen','Rep'].each do |title|
    party = title == 'Sen' ? 'Senators' : 'Representative(s)'
    legislator_count = Legislator.where("state = ? and title = ?", state_abbr, title).length
    output += "#{legislator_count} #{party}, "
  end
  puts output[0..-3]
end

def active_by_state
  states = Legislator.group(:state).sum(:in_office)
  sorted_states = states.sort_by { |state, count| count }.reverse
  sorted_states.each { |state| legislator_count_from(state[0]) }
end

### count total legislators ###

def total
  legislators = Legislator.group(:title).count
  sens = legislators["Sen"]
  reps = legislators["Rep"]
  puts "Senators: #{sens}"
  puts "Republicans: #{reps}"
end

def delete_inactive
  Legislator.where(in_office: 0).destroy_all
end

### driver code ###

all_legislators_from("IL")
legislator_ratios
active_by_state
total
puts
delete_inactive
total
