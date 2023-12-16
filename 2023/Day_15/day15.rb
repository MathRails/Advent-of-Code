data = Array.new
values = Array.new

def calculate_hash(letters)
  value = 0
  letters.each_char do |letter|
    value += letter.ord
    value *= 17
    value %= 256
  end
  value
end

File.read("data").split(",").each { |element| data << element }

# Part 1
data.each { |k| values << calculate_hash(k) }
puts values.reduce(&:+)

# Part 2
boxes = Array.new(256) { [] }

data.each do |operation|
  if operation.include? "-"
    label, value = operation.split("-")
    box = calculate_hash(label)

    position = boxes[box].find_index { |op| op[0] == label }
    boxes[box].delete_at(position) if position != nil
  elsif operation.include? "="
    label, value = operation.split("=")
    box = calculate_hash(label)

    position = boxes[box].find_index { |op| op[0] == label }
    if position
      boxes[box][position][1] = value.to_i
    else
      boxes[box].append([label, value.to_i])
    end
  end
end

power = 0
boxes.each_with_index do |box, idx_box|
  box_power = 0
  box.each_with_index do |lens, idx_lens|
    box_power += (1 + idx_box) * (idx_lens + 1) * lens[1]
  end
  power += box_power
end

puts power
