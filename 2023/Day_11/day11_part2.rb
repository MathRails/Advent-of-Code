image = File.readlines("data").map { |line| line.chomp.chars }

def find_positions(tableau, caractere)
  positions = []

  tableau.each_with_index do |ligne, i|
    ligne.each_with_index do |element, j|
      positions << [i, j] if element == caractere
    end
  end

  positions
end

def get_nb_empty(a, b, image)
  x = [a[1], b[1]].sort
  y = [a[0], b[0]].sort

  nb_y = image[y.first..y.last].count { |ligne| !ligne.include?("#") }
  nb_x =
    (x.first..x.last).count { |col| image.all? { |ligne| ligne[col] != "#" } }

  [nb_x * 999_999, nb_y * 999_999]
end

galaxies_coord = find_positions(image, "#")
galaxies_length = []

while galaxies_coord.length >= 2
  galaxie = galaxies_coord[-1]

  galaxies_coord.each do |coord|
    next if galaxie == coord
    count_empty_x, count_empty_y = get_nb_empty(galaxie, coord, image)
    galaxies_length << ((coord[0] - galaxie[0]).abs + count_empty_y) +
      ((coord[1] - galaxie[1]).abs + count_empty_x)
  end

  galaxies_coord.pop
end

puts galaxies_length.reduce(&:+)
