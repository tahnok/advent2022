require 'pp'
require 'matrix'

raw_grid = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]

start = raw_grid.index('S')
dest = raw_grid.index('E')

raw_grid[*start] = 'a'
raw_grid[*dest] = 'z'

elevation = raw_grid.map{|x| x.ord - 'a'.ord}

def a_star(elevation, start, dest)
  to_explore = [start]
  dist_from_start = { start => 0 }
end
