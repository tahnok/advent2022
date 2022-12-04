require 'set'

$letter_to_score_less_one = (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index.to_h

def common_item_priority(inv)
  left, right = inv.chars.each_slice(inv.length / 2).map(&:to_set)
  return $letter_to_score_less_one.fetch((right & left).first) + 1
end


puts ARGF.read.split("\n").map{|b| common_item_priority(b)}.sum
