puts ARGF.read.chomp.chars.each_cons(14).find_index {|c| c.uniq == c} + 14
