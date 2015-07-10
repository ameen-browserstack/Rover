class Plateau
  attr_accessor :n,:m,:rovers

  def initialize(n,m)
    @n = n.to_i
    @m = m.to_i
    @rovers = []
  end

  def add_rover(r)
    @rovers << r
  end

end

class InvalidMoveException < Exception
end

class Rover
  attr_reader :x,:y,:direction
  DIRECTIONS = "WNES"

  def initialize(x,y,direction,plateau, cmd)
    @x = x.to_i
    @y = y.to_i
    @direction = direction.to_s
    @plateau = plateau
    @cmd = cmd
  end

  def spin_left 
    @direction = DIRECTIONS[DIRECTIONS.index(@direction)-1]
  end

  def spin_right
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction)+1)%4]
  end

  def move_not_valid?
    if @x < 0 or @x > @plateau.n or @y < 0 or @y > @plateau.m
      return true
    else 
      return false
    end
  end

  def rovers_crashing?
    @plateau.rovers.each do |r|
      if r.x == @x and r.y == @y and r != self
        return true
      end
    end
    return false
  end



  def move
    x = @x
    y = @y

    case @direction
    when "N"
      @y += 1
    when "S"
      @y -= 1
    when "E"
      @x += 1
    when "W"
      @x -= 1
    end

    if move_not_valid?
      @x = x
      @y = y
      raise InvalidMoveException, "Cannot move #{@direction} from #{@x}, #{@y}"
    end

    if rovers_crashing?
      @x = x
      @y = y
      raise InvalidMoveException, 
        "ROVERS crashing when trying to move #{@direction} from #{@x}, #{@y}"
    end
  end

  def execute
    @cmd.each_char do |c|
      case c
      when "L" 
        spin_left
      when "R"
        spin_right
      when "M"
        move
      end
    end
  end
end

