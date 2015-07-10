require_relative "rover.rb"
require "test/unit"

class TestGame < Test::Unit::TestCase

  def test_case_1
    p = Plateau.new(5,5)
    r = Rover.new(1,2,"N",p,"LMLMLMLMM")
    p.add_rover r
    r.execute
    assert r.x == 1 and r.y == 3 and r.direction == "N"
  end

  def test_case_2
    p = Plateau.new(5,5)
    r = Rover.new(3,3,"E",p,"MMRMMRMRRM")
    p.add_rover r
    r.execute
    assert r.x == 5 and r.y == 1 and r.direction == "E"
  end

  def test_case_3
    p = Plateau.new(5,5)
    r1 = Rover.new(1,2,"N",p,"LMLMLMLMM")
    r2 = Rover.new(3,3,"E",p,"MMRMMRMRRM")
    p.add_rover r1
    p.add_rover r2
    r1.execute
    r2.execute
    assert r1.x == 1 and r1.y == 3 and r1.direction == "N"
    assert r2.x == 5 and r2.y == 1 and r2.direction == "E"
  end


  def test_invalid_move
    p = Plateau.new(5,5)
    r = Rover.new(5,5,"E",p,"M")
    p.add_rover r
    assert_raise(InvalidMoveException) do
      r.execute
    end
  end

  def test_invalid_move_2
    p = Plateau.new(5,5)
    r = Rover.new(1,2,"N",p,"MMMMMMMMMMMMM")
    p.add_rover r
    assert_raise(InvalidMoveException) do
      r.execute
    end
  end

  def test_invalid_move_3
    p = Plateau.new(5,5)
    r = Rover.new(1,2,"N",p,"LMMMM")
    assert_raise(InvalidMoveException) do
      r.execute
    end
  end

  def test_rovers_crashing
    p = Plateau.new(5,5)
    r1 = Rover.new(1,2,"N",p,"MM")
    r2 = Rover.new(1,3,"S",p,"MLM")
    p.add_rover r1
    p.add_rover r2
    assert_raise(InvalidMoveException) do
      r1.execute
      r2.execute
    end
  end
end
