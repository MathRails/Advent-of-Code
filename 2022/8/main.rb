file = File.open('input.txt')
forest = file.read.split("\n").map { |line| line.split('').map(&:to_i) }

trees_visible = 0
highest_scenic_score = 0

forest.each_with_index do |line_forest, i|
  line_forest.each_with_index do |col_forest, j|
    # Arbre en peripherie
    if j == 0 || j == line_forest.length() - 1 || i == 0 ||
         i == forest.length() - 1
      trees_visible += 1
      next
    end

    # Arbre l interieur
    gauche = line_forest[..j - 1]
    droite = line_forest[j + 1..line_forest.length()]
    x = line_forest[j] > gauche.max || line_forest[j] > droite.max

    haut = forest.transpose[j][..i - 1]
    bas = forest.transpose[j][i + 1..line_forest.length()]
    y = line_forest[j] > haut.max || line_forest[j] > bas.max

    trees_visible += 1 if x || y

    # Score scenic

    score_g = 0
    score_d = 0
    score_h = 0
    score_b = 0

    gauche.reverse.each do |val|
      if line_forest[j] > val
        score_g += 1
      elsif line_forest[j] == val
        score_g += 1
        break
      end
    end

    droite.each do |val|
      if line_forest[j] > val
        score_d += 1
      elsif line_forest[j] == val
        score_d += 1
        break
      end
    end

    haut.reverse.each do |val|
      if line_forest[j] > val
        score_h += 1
      elsif line_forest[j] == val
        score_h += 1
        break
      end
    end

    bas.each do |val|
      if line_forest[j] > val
        score_b += 1
      elsif line_forest[j] == val
        score_b += 1
        break
      end
    end
    score = score_d * score_g * score_h * score_b
    highest_scenic_score = score if score > highest_scenic_score
  end
end

puts trees_visible
print highest_scenic_score
