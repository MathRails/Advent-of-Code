file = File.open ('input.txt')

position_head = [0, 0]
position_tail = [0, 0]
list_position_tail = [0, 0]
visited = []
knots = [
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
  [0, 0],
]

if !list_position_tail.include? [position_tail[0], position_tail[1]]
  list_position_tail << [position_tail[0], position_tail[1]]
end

def move_tail(position_head, position_tail)
  distance_row = position_head[0] - position_tail[0]
  distance_col = position_head[1] - position_tail[1]

  return if distance_col.abs <= 1 && distance_row.abs <= 1

  if position_head[0] == position_tail[0]
    position_tail[1] < position_head[1] ?
      position_tail[1] += 1 :
      position_tail[1] -= 1
  elsif position_head[1] == position_tail[1]
    position_tail[0] < position_head[0] ?
      position_tail[0] += 1 :
      position_tail[0] -= 1
  else
    if position_head[0] > position_tail[0]
      position_tail[0] += 1
    else
      position_tail[0] -= 1
    end

    if position_head[1] > position_tail[1]
      position_tail[1] += 1
    else
      position_tail[1] -= 1
    end
  end
end

file.each do |line|
  direction, step = line.split(' ').map(&:strip)

  for i in 1..step.to_i
    case direction
    when 'D'
      position_head[0] -= 1
      knots[0][1] -= 1
    when 'U'
      position_head[0] += 1
      knots[0][1] += 1
    when 'R'
      position_head[1] += 1
      knots[0][0] += 1
    when 'L'
      position_head[1] -= 1
      knots[0][0] -= 1
    end
    # part 1
    move_tail(position_head, position_tail)

    #part 2
    knots.each_cons(2) { |head_pos, tail_pos| move_tail(head_pos, tail_pos) }
    visited << knots[9]

    if !list_position_tail.include? [position_tail[0], position_tail[1]]
      list_position_tail << [position_tail[0], position_tail[1]]
    end
  end
end

puts list_position_tail.length
puts visited.length
