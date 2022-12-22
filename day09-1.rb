require 'set'

moves = ARGF.readlines.map{|l| dir, num = l.split(" "); [dir, num.to_i]}

def simulate(moves)
  visited = Set.new
  head_loc = [0,0]
  tail_loc = [0,0]
  visited.add(tail_loc)
  moves.each do |dir, mag|
    mag.times do
      h_x, h_y = head_loc
      t_x, t_y = tail_loc
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
      head_loc = [h_x, h_y]

      next if head_loc == tail_loc

      d_x = h_x - t_x
      d_y = h_y - t_y

      if d_x == 2 && d_y == 0 # right
        t_x += 1
      elsif (d_x == 2 && d_y == 1) || (d_x == 1 && d_y == 2) # up right
        t_x += 1
        t_y += 1
      elsif d_x == 0 && d_y == 2 # up
        t_y += 1
      elsif (d_x == -2 && d_y == 1) || (d_x == -1 && d_y == 2) # up right
        t_x -= 1
        t_y += 1
      elsif d_x == -2 && d_y == 0 # left
        t_x -= 1
      elsif (d_x == -2 && d_y == -1) || (d_x == -1 && d_y == -2) # down right
        t_x -= 1
        t_y -= 1
      elsif d_x == 0 && d_y == -2 # down
        t_y -= 1
      elsif (d_x == 2 && d_y == -1) || (d_x == 1 && d_y == -2) #down left
        t_x += 1
        t_y -= 1
      end


      tail_loc = [t_x, t_y]
      visited.add(tail_loc)
    end
  end


  return visited.length
end

puts simulate(moves)
