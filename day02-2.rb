THEIR_MOVE_MAP = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors,
}

OUTCOME_MAP = {
  'X' => :loose,
  'Y' => :draw,
  'Z' => :win,
}

SCORE_MAP = {
  rock: 1,
  paper: 2,
  scissors: 3,
}

def my_move(theirs, outcome)
  return theirs if outcome == :draw
  if (theirs == :rock && outcome == :win) ||
      (theirs == :scissors && outcome == :loose)
    return :paper
  elsif (theirs == :rock && outcome == :loose) ||
    (theirs == :paper && outcome == :win)
    return :scissors
  elsif (theirs == :scissors && outcome == :win) ||
    (theirs == :paper && outcome == :loose)
    return :rock
  else
    raise "unknown match with #{theirs} for outcome #{outcome}"
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
  theirs, outcome = match.split(" ")
  theirs = THEIR_MOVE_MAP.fetch(theirs)
  outcome = OUTCOME_MAP.fetch(outcome)
  mine = my_move(theirs, outcome)
  score = SCORE_MAP.fetch(mine)
  score += score_match(theirs, mine)
}.sum
