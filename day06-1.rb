puts ARGF.read.chomp.chars.each_cons(4).find_index {|c| c.uniq == c} + 4
