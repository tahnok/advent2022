require 'pp'

class Monkey
  attr_accessor :items, :mod
  attr_reader :number, :op, :true_monkey, :false_monkey, :inspections, :divisor

  def self.from_raw(raw)
    lines = raw.split("\n").map(&:chomp)

    number = /Monkey (\d+)/.match(lines[0])[1].to_i

    items = lines[1].split(":").last.split(",").map(&:to_i)

    raw_operation = lines[2].split(" ")
    op = if raw_operation.last == "old"
      lambda {|old, mod| old.send(raw_operation[4], old) % mod}
    else
      lambda {|old, mod| old.send(raw_operation[4], raw_operation.last.to_i) % mod }
    end

    divisor = lines[3].split(" ").last.to_i

    true_monkey = lines[4].split(" ").last.to_i
    false_monkey = lines[5].split(" ").last.to_i

    new(number, items, op, divisor, true_monkey, false_monkey)
  end

  def initialize(number, items, op, divisor, true_monkey, false_monkey)
    @number = number
    @items = items
    @op = op
    @divisor = divisor
    @true_monkey = true_monkey
    @false_monkey = false_monkey
    @inspections = 0
  end

  def do_inspect!
    passes = Hash.new {|k,v| k[v] = Array.new}
    @items.each do |item|
      @inspections += 1
      worry = @op.call(item, @mod)
      if test(worry)
        passes[@true_monkey] << worry
      else
        passes[@false_monkey] << worry
      end
    end
    @items = []
    passes
  end

  def test(worry)
    worry % @divisor == 0
  end

  def to_s
    "Monkey ##{@number}"
  end
end

def round(monkeys)
  monkeys.each do |monkey|
    passes = monkey.do_inspect!
    passes.each do |m, items|
      monkeys[m].items.push(*items)
    end
  end
  nil
end


monkeys = ARGF.read.split("\n\n").map{|raw| Monkey.from_raw(raw)}
mod = monkeys.map(&:divisor).reduce(&:*)
monkeys.each {|m| m.mod = mod}

10000.times do |i|
  round(monkeys)
end

puts monkeys.map(&:inspections).sort.reverse.take(2).reduce(&:*)
