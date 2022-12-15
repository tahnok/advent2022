require 'debug'
require 'matrix'

tree_grid = ARGF.readlines(chomp: true).map{|l| l.chars.map(&:to_i)}

def mark_visible(row)
  visible = []
  row.length.times do |i|
    left = row.take(i)
    right = row.drop(i + 1)
    if left.all?{|t| t < row[i] } || right.all?{|t| t < row[i] } || left.empty? || right.empty?
      visible << true
    else
      visible << false
    end
  end
  return visible
end

rows = Matrix[*tree_grid.map{|t| mark_visible(t)}]
cols = Matrix[*tree_grid.transpose.map{|t| mark_visible(t)}].transpose

result = Matrix.combine(rows,cols) {|a,b| a || b}

puts result.to_a.flatten.count{|x| x}
