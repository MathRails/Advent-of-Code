map = File.read("data").split("\n").map { |el| el.split("") }

def get_positions(map, symbol)
  lst_pos = Array.new
  map.each_with_index { |element, index| lst_pos << index if element == symbol }
  lst_pos
end

# Part 1
res = 0
map = map.transpose
map.each do |line|
  wall_positions = get_positions(line, "#")

  line.each_with_index do |el, i|
    next if i == 0
    next if el == "#"
    next if el == "."

    empty_pos = get_positions(line, ".").filter { |val| val < i }
    next if el == "O" && empty_pos.empty?

    if wall_positions.filter { |val| val < i }.empty?
      line[empty_pos.min] = "O"
      line[i] = "."
    else
      empty_pos =
        get_positions(line, ".").filter do |val|
          val < i && val > wall_positions.filter { |val| val < i }.max
        end
      if !empty_pos.empty?
        line[empty_pos.min] = "O"
        line[i] = "."
      end
    end
  end
end

map = map.transpose
map.each_with_index { |col, nb| res += col.count("O") * (map.length - nb) }
puts res
