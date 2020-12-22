timetable = File.readlines('input').map(&:strip)

TIMESTAMP = timetable[0].to_i
buses = timetable[1].split(',')

def find_leaving_time_offset(bus_id)
    bus_id.times do |offset|
        return offset if (TIMESTAMP + offset) % bus_id == 0
    end
    raise "Could not find a leaving time"
end


earliest = TIMESTAMP
earliest_id = nil
buses.each do |bus_id|
    next if bus_id == 'x'
    offset = find_leaving_time_offset(bus_id.to_i)
    if offset < earliest
        earliest = offset 
        earliest_id = bus_id.to_i
    end
end

puts "#{earliest} * #{earliest_id} = #{earliest * earliest_id}"
