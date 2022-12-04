require 'set'

$letter_to_score_less_one = (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index.to_h

def common_item_priority(trio)
  badge = trio.map(&:chars).map(&:to_set).reduce(&:&).first
  return $letter_to_score_less_one.fetch(badge) + 1
end


puts ARGF.read.split("\n").each_slice(3).map{|trio| common_item_priority(trio)}.sum
