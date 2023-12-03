resultat = 0

chiffres_en_lettres = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9",
}

File
  .open("data")
  .readlines
  .each do |line|
    resultats = {}

    chiffres_en_lettres.keys.each do |element|
      positions = []
      index = -1

      while (index = line.index(element, index + 1))
        positions << index
      end

      resultats[element] = positions unless positions.empty?
    end

    resultats.each do |digit_letters, position|
      position.each { |el| line[el] = chiffres_en_lettres[digit_letters] }
    end

    res = line.scan(/\d/)
    resultat += "#{res.first}#{res.last}".to_i
  end

puts resultat
