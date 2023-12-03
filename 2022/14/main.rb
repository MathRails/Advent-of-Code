file = File.open('input.txt')
file_content = file.read

res = file_content.scan(/([0-9]+),([0-9]+)/)
max_y = res.map { |arr| arr.first.to_i }.max
min_y = res.map { |arr| arr.first.to_i }.min

max_x = res.map { |arr| arr.last.to_i }.max
min_x = 0

offset_x = max_x - min_x + 1
offset_y = max_y - min_y + 1

def part1(map, infos)
  nb_sand = 0
  stop_sand = false

  until stop_sand
    x, y = 0, 500 - infos[:min_y]
    falling = true

    while falling and not stop_sand
      if x + 1 == infos[:max_x] + 1
        stop_sand = true
      elsif map[x + 1][y] == '.'
        x += 1
      elsif y - 1 < 0
        stop_sand = true
      elsif map[x + 1][y - 1] == '.'
        y -= 1
      elsif y + 1 >= infos[:max_y] + 1 - infos[:min_y]
        stop_sand = true
      elsif map[x + 1][y + 1] == '.'
        y += 1
      else
        falling = false
      end
    end

    nb_sand += 1 unless stop_sand
    map[x][y] = 'o' unless falling
  end
  nb_sand
end

def part2(map, infos)
  nb_sand = 0
  stop_sand = false

  until stop_sand
    x, y = 0, 500 - infos[:min_y]
    falling = true

    while falling and not stop_sand
      if x + 1 == infos[:max_x] + 1
        stop_sand = true
      elsif map[x + 1][y] == '.'
        x += 1
      elsif y - 1 < 0
        stop_sand = true
      elsif map[x + 1][y - 1] == '.'
        y -= 1
      elsif y + 1 >= infos[:max_y] + 1 - infos[:min_y]
        stop_sand = true
      elsif map[x + 1][y + 1] == '.'
        y += 1
      else
        falling = false
      end
    end

    nb_sand += 1 unless stop_sand
    map[x][y] = 'o' unless falling
    stop_sand = true if x == 0 and not falling
  end
  nb_sand
end

def draw(map, file_content, infos)
  file_content
    .split("\n")
    .map do |line|
      positions = line.split(' -> ')
      last_x = nil
      last_y = nil
      positions.each do |position|
        y, x = position.split(',').map(&:to_i)
        if last_x.nil? && last_y.nil?
          new_x = x.to_i
          new_y = y.to_i - infos[:min_y]
          map[new_x][new_y] = '#'
        elsif last_x != x
          step = 0 < last_x - x ? -1 : 1
          new_x = last_x
          ((last_x - x).abs).times do |i|
            new_x += step
            map[new_x][y - infos[:min_y]] = '#'
          end
        elsif last_y != y
          step = 0 < last_y - y ? -1 : 1
          new_y = last_y
          ((last_y - y).abs).times do |i|
            new_y += step
            map[last_x][new_y - infos[:min_y]] = '#'
          end
        end
        last_x = x
        last_y = y
      end
    end
end

map = Array.new(offset_x) { Array.new(offset_y) { '.' } }
map[0][500 - min_y] = '+'
draw(
  map,
  file_content,
  { min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y },
)
puts part1(map, { min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y })
# puts map.map(&:join)

p '----'

map.clear
map = Array.new(offset_x + 2) { Array.new(700) { '.' } }
map[map.length - 1] = Array.new(700) { '#' }
map[0][500] = '+'
draw(
  map,
  file_content,
  { min_x: min_x, max_x: max_x + 2, min_y: 300, max_y: 700 },
)
puts part2(map, { min_x: min_x, max_x: max_x + 2, min_y: 300, max_y: 700 })
# puts map.map(&:join)
