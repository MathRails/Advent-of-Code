image = File.readlines("data").map { |line| line.chomp.chars }

image2 =
  image.flat_map { |line| line.include?("#") ? [line] : [line, line.dup] }
image2 = image2.transpose

image3 =
  image2.flat_map { |line| line.include?("#") ? [line] : [line, line.dup] }
image3 = image3.transpose

def find_positions(tableau, caractere)
  positions = []

  tableau.each_with_index do |ligne, i|
    ligne.each_with_index do |element, j|
      positions << [i, j] if element == caractere
    end
  end

  positions
end

galaxies_coord = find_positions(image3, "#")
galaxies_length = []

while galaxies_coord.length >= 2
  galaxie = galaxies_coord[-1]

  galaxies_coord.each do |coord|
    next if galaxie == coord
    galaxies_length << (coord[0] - galaxie[0]).abs + (coord[1] - galaxie[1]).abs
  end

  galaxies_coord.pop
end

puts galaxies_length.reduce(&:+)
