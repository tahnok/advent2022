instructions = ARGF.readlines(chomp: true).map {|line|
  if line == "noop"
    line
  else
    line.split(" ").last.to_i
  end
}

trace = instructions.each_with_object([1]) {|inst, trace|
  if inst == "noop"
    trace << trace.last
  else
    last = trace.last
    trace << last
    trace << last + inst
  end
}

halts = [20, 60, 100, 140, 180, 220]

puts halts.map { |h| h * trace[h - 1] }.sum

