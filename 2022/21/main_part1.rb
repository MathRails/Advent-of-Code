class Monkey
  attr_reader :name, :var1, :var2, :operation
  attr_accessor :resolve, :resultat

  @@list_monkeys = []

  def initialize(name, *actions)
    @name = name
    if actions.length > 1
      @var1 = actions[0]
      @operation = actions[1]
      @var2 = actions[2]
      @resultat = nil
      @resolve = false
    else
      @resultat = actions[0].to_i
      @resolve = true
    end
    @@list_monkeys << { name: name, monkey: self }
  end

  def self.resolve
    until @@list_monkeys.count { |el| !el[:monkey].resolve } == 0
      @@list_monkeys.each do |m|
        if !m[:monkey].resolve
          var1 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var1 }
          var2 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var2 }

          if var1[:monkey].resolve && var2[:monkey].resolve
            m[:monkey].resultat =
              eval(
                "#{var1[:monkey].resultat} #{m[:monkey].operation} #{var2[:monkey].resultat}",
              )
            m[:monkey].resolve = true
          end
        end
      end
    end
    monkey_root = @@list_monkeys.find { |el| el[:name] == 'root' }
    puts "Solution part 1 : #{monkey_root[:monkey].resultat}"
  end
end

File
  .open('input.txt')
  .each do |line|
    if line =~ /(\w{4}): (?:(\d+)|(\w{4}) (.) (\w{4}))/
      !$2.nil? ? Monkey.new($1, $2) : Monkey.new($1, $3, $4, $5)
    end
  end

Monkey.resolve
