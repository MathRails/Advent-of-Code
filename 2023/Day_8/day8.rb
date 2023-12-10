instructions = Array.new
networks = Hash.new

File
  .open("data")
  .readlines
  .each do |line|
    next if line.empty?

    instructions.concat($1.split("")) if line.match(/^([RL]*)$/)
    networks[$1] = { L: $2, R: $3 } if line.match(
      /([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)/,
    )
  end

def puzzle1(start_network, end_network, networks, instructions)
  current_network = start_network
  nb = -1

  until current_network == end_network
    nb += 1
    position = instructions[(nb % instructions.length())]
    current_network = networks[current_network][position.to_sym]
  end

  nb + 1
end

def puzzle2(end_network, network, instructions, networks)
  nb = 0
  while network[-1] != end_network
    position = instructions[(nb % instructions.length())]
    network = networks[network][position.to_sym]

    nb += 1
  end
  nb
end

puts "Resultat part 1 : #{puzzle1("AAA", "ZZZ", networks, instructions)}"
curr = networks.select { |net| net[-1] == "A" }.keys
lens = curr.map { |net| puzzle2("Z", net, instructions, networks) }

puts lens.reduce(1, :lcm)
