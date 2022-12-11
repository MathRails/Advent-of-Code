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

Monkey.list_monkey << Monkey.new(
  [59, 65, 86, 56, 74, 57, 56],
  'old * 17',
  3,
  3,
  6,
)
Monkey.list_monkey << Monkey.new([63, 83, 50, 63, 56], 'old + 2', 13, 3, 0)
Monkey.list_monkey << Monkey.new([93, 79, 74, 55], 'old + 1', 2, 0, 1)
Monkey.list_monkey << Monkey.new(
  [86, 61, 67, 88, 94, 69, 56, 91],
  'old + 7',
  1,
  6,
  7,
)
Monkey.list_monkey << Monkey.new([76, 50, 51], 'old * old', 19, 2, 5)
Monkey.list_monkey << Monkey.new([77, 76], 'old + 8', 17, 2, 1)
Monkey.list_monkey << Monkey.new([74], 'old * 2', 5, 4, 7)
Monkey.list_monkey << Monkey.new([86, 85, 52, 86, 91, 95], 'old + 6', 7, 4, 5)

modulo = Monkey.list_monkey.reduce(1) { |acc, m| acc * m.divisible }
i = 0
10_000.times do
  Monkey.list_monkey.each do |m|
    m.item_list.each do |item|
      m.nb += 1
      worry_level = eval(m.operation.gsub('old', item.to_s))

      # Part 1
      # worry_level_by_3 = (worry_level / 3.0).floor
      # if worry_level_by_3 % m.divisible == 0
      # Part 2

      if worry_level % modulo == 0
        Monkey.get_monkey(m.divisble_true).item_list << worry_level
      else
        Monkey.get_monkey(m.divisble_false).item_list << worry_level
      end
    end
    m.item_list.clear
  end
end

puts Monkey.list_monkey.map(&:nb).sort.reverse.take(2).reduce(1, :*)
puts "Singe 0 : #{Monkey.get_monkey(0).nb}"
puts "Singe 1 : #{Monkey.get_monkey(1).nb}"
puts "Singe 2 : #{Monkey.get_monkey(2).nb}"
puts "Singe 3 : #{Monkey.get_monkey(3).nb}"
puts "Singe 4 : #{Monkey.get_monkey(4).nb}"
puts "Singe 5 : #{Monkey.get_monkey(5).nb}"
puts "Singe 6 : #{Monkey.get_monkey(6).nb}"
puts "Singe 7 : #{Monkey.get_monkey(7).nb}"
