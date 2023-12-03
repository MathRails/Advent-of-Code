file = File.open('input.txt')
file_content = file.read.split("\n")

def part1(file_content)
  cycles = [20, 60, 100, 140, 180, 220]
  cycles_values = []
  x = 1
  current_cycle = 1

  file_content.each do |line|
    cycles_values << x * current_cycle if cycles.include? current_cycle
    cmd, nb = line.split(' ')

    if cmd == 'noop'
      current_cycle += 1
    else
      current_cycle += 1
      cycles_values << x * current_cycle if cycles.include? current_cycle
      current_cycle += 1
      x += nb.to_i
    end
  end

  cycles_values.sum
end

def part2(file_content)
  pixels = Array.new(6 * 40) { '.' }
  x = 1
  current_cycle = 0

  file_content.each do |line|
    pixels[current_cycle] = '#' if (x - 1..x + 1).include?(current_cycle % 40)
    cmd, nb = line.split(' ')

    if cmd == 'noop'
      current_cycle += 1
    else
      current_cycle += 1
      pixels[current_cycle] = '#' if (x - 1..x + 1).include?(current_cycle % 40)
      current_cycle += 1
      x += nb.to_i
    end
  end

  pixels.each_slice(40).map(&:join)
end

puts part1(file_content)
puts part2(file_content)
