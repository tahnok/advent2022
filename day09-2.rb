require 'set'

moves = ARGF.readlines.map{|l| dir, num = l.split(" "); [dir, num.to_i]}

def print(rope)
  6.downto(0) do |y|
    6.times do |x|
      maybe_knot = rope.find_index([x,y])
      putc maybe_knot&.to_s || "."
    end
    putc "\n"
  end

end

def move_knot(head, tail)
  h_x, h_y = head
  t_x, t_y = tail

  d_x = h_x - t_x
  d_y = h_y - t_y

  if d_x == 2 && d_y == 0 # right
    t_x += 1
  elsif (d_x == 2 && d_y >= 1) || (d_x >= 1 && d_y == 2) # up right
    t_x += 1
    t_y += 1
  elsif d_x == 0 && d_y == 2 # up
    t_y += 1
  elsif (d_x == -2 && d_y >= 1) || (d_x <= -1 && d_y == 2) # up right
    t_x -= 1
    t_y += 1
  elsif d_x == -2 && d_y == 0 # left
    t_x -= 1
  elsif (d_x == -2 && d_y <= -1) || (d_x <= -1 && d_y == -2) # down right
    t_x -= 1
    t_y -= 1
  elsif d_x == 0 && d_y == -2 # down
    t_y -= 1
  elsif (d_x == 2 && d_y <= -1) || (d_x >= 1 && d_y == -2) #down left
    t_x += 1
    t_y -= 1
  end

  return [t_x, t_y]
end

def simulate(moves)
  visited = Set.new
  rope = Array.new(10) { [0,0] }
  visited.add(rope.last)
  moves.each do |dir, mag|
    mag.times do
      h_x, h_y = rope.first
      case dir
      when 'R'
        h_x += 1
      when 'L'
        h_x -= 1
      when 'U'
        h_y += 1
      when 'D'
        h_y -= 1
      else
        raise "Unknown dir #{dir}"
      end
      new_rope = [[h_x, h_y]]
      rope.drop(1).each_with_index do |knot, prev_knot_idx|
        new_rope << move_knot(new_rope[prev_knot_idx], knot)
      end
    
      rope = new_rope
      visited.add(rope.last)
    end
  end


  return visited.length
end

puts simulate(moves)
