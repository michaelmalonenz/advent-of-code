actions = File.readlines('input').map(&:strip)

class Ferry
  def initialize()
    @north = 0
    @east = 0
  end

  def move_in_waypoint_direction(value, waypoint)
    @north += (waypoint.north * value)
    @east += (waypoint.east * value)
  end

  def get_manhattan()
    return @north.abs() + @east.abs()
  end

end

class Waypoint

  attr_reader :north, :east

  def initialize()
    @north = 1
    @east = 10
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
      rotate(value)
    when 'R'
      rotate(-value)
    else
      raise "Unknown action: #{action}"
    end
  end

  private
  def deg_to_rad(value)
    return value * Math::PI / 180 
  end

  def rotate(value)
    ox, oy = 0, 0
    px, py = @east, @north
    angle = deg_to_rad(value)
    qx = ox + Math.cos(angle) * (px - ox) - Math.sin(angle) * (py - oy)
    qy = oy + Math.sin(angle) * (px - ox) + Math.cos(angle) * (py - oy)

    @north = qy.round(0).to_i
    @east = qx.round(0).to_i
  end

end

ferry = Ferry.new()
waypoint = Waypoint.new()
actions.each do |action|
  dir = action[0]
  value = (action[1, action.length - 1]).to_i
  if dir == 'F'
    ferry.move_in_waypoint_direction(value, waypoint)
  else
    waypoint.do_action(dir, value)
  end
end

puts ferry.get_manhattan()
