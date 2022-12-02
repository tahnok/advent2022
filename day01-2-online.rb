puts File.read(ARGV[0]).split("\n\n").map{|x| x.split("\n").map(&:to_i).sum}.sort.slice(-3,3).sum
