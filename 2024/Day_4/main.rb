DATA_INIT = File.open("sample").read().split("\n")
WORD = "XMAS"

def count_word(grid, word)
  tt = 0
  nb_cols = grid[0].length
  nb_rows = grid.length

  # droite <-> gauche
  grid.each do |line|
    tt += line.scan(word).length
    tt += line.scan(word.reverse).length
  end

  # haut <-> bas
  nb_cols.times do |col|
    col_str = grid.map{|row| row[col]}.join
    tt += col_str.scan(word).length
    tt += col_str.scan(word.reverse).length
  end

  tt
end

puts count_word(DATA_INIT, WORD)
