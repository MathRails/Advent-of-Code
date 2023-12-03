class Monkey
  attr_reader :name, :var1, :var2, :operation
  attr_accessor :resolve, :resultat

  @@list_monkeys = []
  @@list_real_monkey = []
  @@list_human_monkey = []

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
    @@list_human_monkey << { name: name, monkey: self } if name == 'humn'
  end

  def self.find_family(node)
    (@@list_monkeys - @@list_human_monkey).each do |m|
      if m[:monkey].var1 == node || m[:monkey].var2 == node
        @@list_human_monkey << m if !@@list_human_monkey.include? m

        var1 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var1 }
        var2 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var2 }

        @@list_human_monkey << var1 if !@@list_human_monkey.include? var1
        @@list_human_monkey << var2 if !@@list_human_monkey.include? var2

        self.find_family(m[:monkey].var1)
        self.find_family(m[:monkey].var2)
        self.find_family(m[:monkey].name)
      end
    end
  end

  def self.part2
    monkey_root = @@list_monkeys.find { |el| el[:name] == 'root' }
    self.find_family('humn')
    @@list_real_monkey = @@list_monkeys - @@list_human_monkey

    root_monkey_equality_key = @@list_real_monkey - @@list_human_monkey
    root_human_equality_key = @@list_human_monkey - @@list_real_monkey

    @@list_human_monkey.delete(root_human_equality_key)
    @@list_real_monkey.delete(root_monkey_equality_key)
  end

  def self.resolve
    self.find_family('humn')
    print @@list_human_monkey
    # @@list_human_monkey.each { |el| puts el[:name] }

    # until @@list_monkeys.count { |el| !el[:monkey].resolve } == 0
    #   @@list_monkeys.each do |m|
    #     if !m[:monkey].resolve
    #       var1 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var1 }
    #       var2 = @@list_monkeys.find { |el| el[:name] == m[:monkey].var2 }

    #       if var1[:monkey].resolve && var2[:monkey].resolve
    #         m[:monkey].resultat =
    #           eval(
    #             "#{var1[:monkey].resultat} #{m[:monkey].operation} #{var2[:monkey].resultat}",
    #           )
    #         m[:monkey].resolve = true
    #       end
    #     end
    #   end
    # end
  end
end

File
  .open('input_test.txt')
  .each do |line|
    if line =~ /(\w{4}): (?:(\d+)|(\w{4}) (.) (\w{4}))/
      !$2.nil? ? Monkey.new($1, $2) : Monkey.new($1, $3, $4, $5)
    end
  end

Monkey.part2
