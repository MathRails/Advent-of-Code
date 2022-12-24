class Monkey
  attr_accessor :item_list, :nb
  attr_reader :operation, :divisible, :divisble_false, :divisble_true

  @@monkeys_list = Array.new()

  def initialize(
    item_list,
    operation,
    divisible,
    divisible_true,
    divisible_false
  )
    @item_list = item_list
    @operation = operation
    @divisible = divisible
    @divisble_true = divisible_true
    @divisble_false = divisible_false
    @nb = 0
  end

  def self.get_monkey(id)
    @@monkeys_list[id]
  end

  def self.list_monkey
    @@monkeys_list
  end
end

PATTERN = Regexp.new(<<~REGEXP.strip)
Monkey (?<id>\\d+):
  Starting items: (?<items>[0-9 ,]+)
  Operation: new = (?<operation>.*)
  Test: divisible by (?<test>\\d+)
    If true: throw to monkey (?<pass>\\d+)
    If false: throw to monkey (?<fail>\\d+)
REGEXP

File
  .read('input.txt')
  .split("\n\n")
  .each_with_object({}) do |definition, monkeys|
    data = PATTERN.match(definition)
    Monkey.list_monkey << Monkey.new(
      data[:items].split(', ').map(&:to_i),
      data[:operation],
      data[:test].to_i,
      data[:pass].to_i,
      data[:fail].to_i,
    )
  end

def solve(round, div)
  round.times do
    Monkey.list_monkey.each do |m|
      m.item_list.each do |item|
        m.nb += 1
        worry_level = eval(m.operation.gsub('old', item.to_s))

        #part 1
        # worry_level_div = worry_level / div
        #part 2
        worry_level_div = worry_level % div

        if worry_level_div % m.divisible == 0
          Monkey.get_monkey(m.divisble_true).item_list << worry_level_div
        else
          Monkey.get_monkey(m.divisble_false).item_list << worry_level_div
        end
      end
      m.item_list.clear
    end
  end
end

# Part 1
#solve(20, 3)
#puts Monkey.list_monkey.map(&:nb).sort.reverse.take(2).reduce(1, :*)

# Part 2
div = Monkey.list_monkey.map { |m| m.divisible }.reduce(:*)
solve(10_000, div)
puts Monkey.list_monkey.map(&:nb).sort.reverse.take(2).reduce(1, :*)
