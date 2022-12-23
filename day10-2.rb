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

pixels = trace.each_with_index.map {|sprite, index|
  pixel = index % 40
  if (sprite - pixel).abs < 2
    "#"
  else
    "."
  end
}

puts pixels.each_slice(40).map{|x| x.join("")}.join("\n")
  
