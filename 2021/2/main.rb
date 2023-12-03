file = File.open("input.txt")
file_content = file.read
h = 0
d = 0

h2 = 0
d2 = 0
aim = 0

file_content
  .split("\n")
  .each do |line|
    command, number = line.split(" ")
    if command == "forward"
      h += number.to_i
    elsif command == "down"
      d += number.to_i
    else
      d -= number.to_i
    end
  end

puts h * d

file_content
  .split("\n")
  .each do |line|
    command, number = line.split(" ")
    if command == "forward"
      h2 += number.to_i
      d2 = (aim * number.to_i) + d2
    elsif command == "down"
      aim += number.to_i
    else
      aim -= number.to_i
    end
  end

puts h2 * d2
