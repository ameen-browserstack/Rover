require_relative "rover.rb"

n, m = gets.chomp.split
p = Plateau.new(n,m)
while line = gets
  x,y,direction = line.split
  cmd = gets.chomp
  r = Rover.new(x,y,direction,p,cmd)
  p.add_rover(r)
end

p.rovers.each do |r|
  r.execute
  puts "#{r.x} #{r.y} #{r.direction}"
end
