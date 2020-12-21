actions = File.readlines("input").map(&:strip)

class Ferry
  def initialize()
    @heading = 90
    @north = 0
    @east = 0
  end

  def do_action(action, value)
    case action
    when 'N'
      @north += value
    when 'S'
      @north -= value
    when 'E'
      @east += value
    when 'W'
      @east -= value
    when 'L'
      @heading = (@heading - value) % 360
    when 'R'
      @heading = (@heading + value) % 360
    when 'F'
      case @heading
      when 0
        @north += value
      when 90
        @east += value
      when 180
        @north -= value
      when 270
        @east -= value
      else
        raise "Unknown Heading: #{@heading}"
      end
    else
      raise "Unknown action: #{action}"
    end
  end

  def get_manhattan()
    return @north.abs() + @east.abs()
  end
end

ferry = Ferry.new()
actions.each do |action|
  dir = action[0]
  value = (action[1, action.length - 1]).to_i
  ferry.do_action(dir, value)
end

puts ferry.get_manhattan()
