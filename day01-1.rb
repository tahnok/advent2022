input = File.read(ARGV[0])

calories = []
elves = 0

input.split("\n").each do |line|
  calories[elves] ||= 0
  if line == ""
    elves += 1
  else
    calories[elves] += line.to_i
  end
end

puts calories.max
