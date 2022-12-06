require 'set'

puts ARGF.readlines.map { |pair|
  left_start, left_end, right_start, right_end = pair.split(/(?:-|,)/).map(&:to_i)
  left = (left_start..left_end).to_set
  right = (right_start..right_end).to_set
  if left.subset?(right) or right.subset?(left)
    1
  else
    0
  end
}.sum
