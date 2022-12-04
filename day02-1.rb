def code_to_move(move)
  case move
  when 'X', 'A'
    :rock
  when 'Y', 'B'
    :paper
  when 'Z', 'C'
    :scissors
  else
    raise "Unknown move #{move}"
  end
end

def score_move(move)
  case move
  when :rock
    1
  when :paper
    2
  when :scissors
    3
  else
    raise "Unknown move #{move}"
  end
end

def score_match(theirs, mine)
  return 3 if theirs == mine

  if (theirs == :rock && mine == :paper) ||
      (theirs == :paper && mine == :scissors) ||
      (theirs == :scissors && mine == :rock)
    6
  elsif (theirs == :rock && mine == :scissors) ||
    (theirs == :paper && mine == :rock) ||
    (theirs == :scissors && mine == :paper)
    0
  else
    raise "Unknown match #{theirs} vs #{mine}"
  end
end


puts ARGF.read.split("\n").map {|match|
  theirs, mine = match.split(" ").map{|x| code_to_move(x)}
  score = score_move(mine)
  score += score_match(theirs, mine)
}.sum
