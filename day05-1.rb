raw_stacks, moves = ARGF.read.split("\n\n")

def parse_stacks(raw_stacks)
  lines = raw_stacks.split("\n").reverse
  size = ((lines.shift.length + 1) / 4)
  stacks = Hash.new{|h,k| h[k] = [] }
  lines.each do |line|
    size.times do |i|
      val = line[i * 4 + 1]
      stacks[i + 1].append(val) if val != " "
    end
  end
  return stacks
end

stacks = parse_stacks(raw_stacks)
moves = moves.split("\n")

def handle_move(stacks, move)
  /(?<qty>\d+).*(?<from>\d+).*(?<to>\d+)/ =~ move
  x = stacks[from.to_i].pop(qty.to_i)
  stacks[to.to_i] += x.reverse
end

moves.each { |move| handle_move(stacks, move) }
puts stacks.values.map{|v| v.last}.join()
