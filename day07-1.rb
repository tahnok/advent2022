MFile = Struct.new("MFile", :name, :size)

class Folder
  attr_accessor :name, :parent, :children
  def initialize(name, parent)
    @children = []
    @name = name
    @parent = parent
  end

  def size
    @children.map(&:size).sum
  end
  
  def to_s
    return "Folder (#{@name}), #{children.map(&:name).inspect}: #{self.size}"
  end
end

def handle_cd(chunk, fs, cwd)
  _, new = chunk.split(" ")
  new = new.chomp
  if new == '..'
    new = fs[cwd].parent
  elsif new == "/"
    new = "/"
  else
    new = "#{cwd}#{new}/"
  end
  return [fs, new]
end

def handle_ls(chunk, fs, cwd)
  lines = chunk.split("\n").drop(1)
  lines.each do |l|
    first, second = l.split(" ")
    if first == "dir"
      name = "#{cwd}#{second}/"
      f = Folder.new(name, cwd)
      fs[name] = f
      fs[cwd].children << f
    else
      f = MFile.new(second, first.to_i)
      fs[cwd].children << f
    end
  end
  return [fs, cwd]
end

def parse_chunk(chunk, fs, cwd)
  if chunk.start_with?("cd")
    return handle_cd(chunk, fs, cwd)
  elsif chunk.start_with?("ls")
    return handle_ls(chunk, fs, cwd)
  else
    raise "Unknown chunk #{chunk.inspect}"
  end
end

chunks = ARGF.read.split("$ ").drop(1)

cwd = nil
fs = { '/' => Folder.new('/', nil) }

chunks.each do |c|
  fs, cwd = parse_chunk(c, fs, cwd)
end

puts fs.values.map(&:size).filter{|x| x <= 100000}.sum
