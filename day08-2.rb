require 'debug'
require 'matrix'

tree_grid = ARGF.readlines(chomp: true).map{|l| l.chars.map(&:to_i)}

def mark_visible(row)
  visible = []
  row.length.times do |i|
    height = row[i]
    left_trees = row.take(i)
    if left_trees.length > 0
      # I'm counting wrong because you can include the tree that's taller in the count
      # but you don't need to add one if you're at the edge
      left_view = left_trees.reverse.take_while{|t| height > t}.length
      left_view += 1 if left_view < left_trees.length
    else
      left_view = 0
    end

    
    right_trees = row.drop(i + 1)
    if right_trees.length > 0
      right_view = right_trees.take_while{|t| height > t}.length
      right_view += 1 if right_view < right_trees.length
    else
      right_view = 0
    end

    visible << left_view * right_view
  end
  return visible
end

rows = Matrix[*tree_grid.map{|t| mark_visible(t)}]
cols = Matrix[*tree_grid.transpose.map{|t| mark_visible(t)}].transpose

result = Matrix.combine(rows,cols) {|a,b| a * b}

puts result.to_a.flatten.max
