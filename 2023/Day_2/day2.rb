resultat1 = 0
resultat2 = 0

def check_game(id, games)
  target = { "red" => 12, "green" => 13, "blue" => 14 }

  games.each do |g|
    g.each do |s|
      combi = /(?<nb>\d+) (?<color>\D+)/.match(s)
      return 0 if combi[:nb].to_i > target[combi[:color]]
    end
  end
  return id.to_i
end

def minimum_required_cube(games)
  minimum = { "green" => 0, "blue" => 0, "red" => 0 }

  games.each do |g|
    g.each do |s|
      combi = /(?<nb>\d+) (?<color>\D+)/.match(s)
      minimum[combi[:color]] = combi[:nb].to_i if minimum[combi[:color]] <
        combi[:nb].to_i
    end
  end
  minimum.values.reduce(:*)
end

File
  .open("data")
  .readlines
  .each do |line|
    data = /Game (?<id>\d+): (?<data>.+)/.match(line)
    id = data[:id]
    games = data[:data].split(";").map { |el| el.split(",") }

    resultat1 += check_game(id, games)
    resultat2 += minimum_required_cube(games)
  end

puts resultat1
puts resultat2
