elfs = []
file = File.read('input.txt')
file
  .split("\n")
  .each_with_index do |el1, r|
    el1
      .split('')
      .each_with_index do |el2, c|
        if el2 == '#'
          elfs << { current_position: [r, c], proposed_destination: nil }
        end
      end
  end

print elfs

MAX_X = 72
MAX_Y = 72

DIRECTION_COORDINATE = {
  N: [-1, 0],
  S: [1, 0],
  E: [0, 1],
  W: [0, -1],
  NE: [-1, 1],
  NW: [-1, -1],
  SE: [1, 1],
  SW: [1, -1],
}

DIRECTION = %i[N S W E]

def find_elf_around(elfs, elf)
  lst_pos = elfs.map { |el| el[:current_position] }

  DIRECTION_COORDINATE.each do |_, coord|
    c = [
      elf[:current_position][0] + coord[0],
      elf[:current_position][1] + coord[1],
    ]

    return true if lst_pos.include? c
  end
  false
end

def next_direction(direction)
  DIRECTION[(DIRECTION.index(direction) + 1) % DIRECTION.size]
end

def check_limit_coord(coord)
  coord[0] <= MAX_Y && coord[1] <= MAX_X && coord[0] >= 0 && coord[1] >= 0
end

def find_new_position(elfs, elf, direction)
  c1 = nil
  c2 = nil
  c3 = nil

  nb_tentative = 1
  try_direction = direction.clone
  direction_find = false

  lst_pos = elfs.map { |el| el[:current_position] }
  elf[:proposed_destination] = elf[:current_position]

  while nb_tentative <= 4 && !direction_find
    c1 = [
      elf[:current_position][0] + DIRECTION_COORDINATE[try_direction][0],
      elf[:current_position][1] + DIRECTION_COORDINATE[try_direction][1],
    ]
    case try_direction
    when :N
      c2 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:NE][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:NE][1],
      ]
      c3 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:NW][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:NW][1],
      ]
    when :S
      c2 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:SE][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:SE][1],
      ]
      c3 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:SW][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:SW][1],
      ]
    when :W
      c2 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:NW][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:NW][1],
      ]
      c3 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:SW][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:SW][1],
      ]
    when :E
      c2 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:NE][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:NE][1],
      ]
      c3 = [
        elf[:current_position][0] + DIRECTION_COORDINATE[:SE][0],
        elf[:current_position][1] + DIRECTION_COORDINATE[:SE][1],
      ]
    end

    # if !lst_pos.include?(c1) && !lst_pos.include?(c2) &&
    #      !lst_pos.include?(c3) && check_limit_coord(c1)
    if !lst_pos.include?(c1) && !lst_pos.include?(c2) && !lst_pos.include?(c3)
      elf[:proposed_destination] = c1
      direction_find = true
    else
      nb_tentative += 1
      try_direction = next_direction(try_direction)
    end
  end
end

def solve(elfs)
  current_direction = :N
  no_move = nil
  10.times do |i|
    # Part 1
    elfs.each_with_index do |elf, i|
      # Si il n y a pas d elf autour next
      presence_elf = find_elf_around(elfs, elf)
      next if !presence_elf

      # Si elf present autour on calcul la potentielle nouvelle position en suivant l ordre des directions
      find_new_position(elfs, elf, current_direction)
    end

    # Part 2
    elfs.each do |elf|
      next if elf[:proposed_destination] == nil
      same_destination =
        elfs.select do |el|
          el[:proposed_destination] == elf[:proposed_destination]
        end

      if same_destination.length > 1
        same_destination.each { |e| e[:proposed_destination] = nil }
        no_move = i + 1 if no_move == nil
        next
      end

      elf[:current_position] = elf[:proposed_destination]
      elf[:proposed_destination] = nil
    end

    current_direction = next_direction(current_direction)
  end

  min_x = elfs.map { |el| el[:current_position][0] }.min
  max_x = elfs.map { |el| el[:current_position][1] }.max
  min_y = elfs.map { |el| el[:current_position][0] }.min
  max_y = elfs.map { |el| el[:current_position][1] }.max

  y = max_y - min_y + 1
  x = max_x - min_x + 2
  nb_elfs = elfs.length

  puts "Part 1 #{y * x - nb_elfs}"
end

solve(elfs)
