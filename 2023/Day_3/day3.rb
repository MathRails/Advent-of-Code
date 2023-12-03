DATA = File.open("data").read.split("\n")

MAX_X = DATA[0].length - 1
MAX_Y = DATA.length - 1
gear_positions = []

resultat1 = 0
resultat2 = 0

## Part 1

def find_symbol(y_row, start_x, end_x)
  positions_check = []

  if start_x == 0
    border_start_x = start_x
  else
    border_start_x = start_x - 1
  end

  if end_x == MAX_X
    border_end_x = end_x
  else
    border_end_x = end_x + 1
  end

  if y_row == 0
    border_start_y = y_row
  else
    border_start_y = y_row - 1
  end

  if y_row == MAX_Y
    border_end_y = y_row
  else
    border_end_y = y_row + 1
  end

  (border_start_x..border_end_x).each do |x|
    (border_start_y..border_end_y).each { |y| positions_check << [y, x] }
  end

  exclude = %w[1 2 3 4 5 6 7 8 9 0 .]

  positions_check.each do |coord|
    res = DATA[coord[0]][coord[1]]
    return true if !exclude.include?(res)
  end
  false
end

DATA.each_with_index do |row, y|
  numbers_in_row = row.scan(/(\d+)/).flatten
  last = 0

  numbers_in_row.each do |number|
    start_position = last + row[last..-1].index(number)
    end_position = start_position + number.length - 1
    gear_positions << {
      "num" => number.to_i,
      "row_pos" => y,
      "start_pos" => start_position,
      "end_pos" => end_position,
    }
    last = end_position
    resultat1 += number.to_i if find_symbol(y, start_position, end_position)
  end
end

## Part 2

DATA.each_with_index do |row, y|
  asterisks = row.scan(/(\*)/).flatten
  last = 0

  asterisks.each do |ask|
    start_position = last + row[last..-1].index(ask)
    last = start_position + 1

    potentials_gear =
      gear_positions.filter do |gear|
        (
          gear["row_pos"] == y || gear["row_pos"] == y - 1 ||
            gear["row_pos"] == y + 1
        ) &&
          (gear["start_pos"] - 1..gear["end_pos"] + 1).include?(start_position)
      end

    if potentials_gear.length == 2
      resultat2 += potentials_gear[0]["num"] * potentials_gear[1]["num"]
      next
    end
  end
end

puts resultat1
puts resultat2
