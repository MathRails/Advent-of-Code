file = File.open("input.txt")

stacks = [
    ['V', 'C', 'D', 'R', 'Z', 'G', 'B', 'W'],
    ['G','W','F','C','B','S','T','V'],
    ['C','B','S','N','W'],
    ['Q','G','M','N','J','V','C','P'],
    ['T','S','L','F','D','H','B'],
    ['J','V','T','W','M','N'],
    ['P','F','L','C','S','T','G'],
    ['B','D','Z'],
    ['M','N','Z','W']
]

stacks2 = [
    ['V', 'C', 'D', 'R', 'Z', 'G', 'B', 'W'],
    ['G','W','F','C','B','S','T','V'],
    ['C','B','S','N','W'],
    ['Q','G','M','N','J','V','C','P'],
    ['T','S','L','F','D','H','B'],
    ['J','V','T','W','M','N'],
    ['P','F','L','C','S','T','G'],
    ['B','D','Z'],
    ['M','N','Z','W']
]

file_content = file.read
file_content = file_content.split("\n")
file_content.shift(10)

file_content.each do |line|
    nb, id_stack_src, id_stack_dst = line.split(" ").select{|data| Integer(data, exception:false)}
    stacks[id_stack_dst.to_i-1].concat(stacks[id_stack_src.to_i-1].pop(nb.to_i).reverse)
    stacks2[id_stack_dst.to_i-1].concat(stacks2[id_stack_src.to_i-1].pop(nb.to_i))
end
puts stacks.map{|stack| stack[-1]}.join
puts stacks2.map{|stack| stack[-1]}.join