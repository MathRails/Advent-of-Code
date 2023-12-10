hands = Array.new

File
  .open("data")
  .readlines
  .each do |line|
    _hand, _bid = line.split(" ")
    hands << { hand: _hand, bid: _bid, type: nil }
  end

def detect_type(hand)
  rule_part_2 = true
  types = [
    [5],
    [1, 4],
    [2, 3],
    [1, 1, 3],
    [1, 2, 2],
    [1, 1, 1, 2],
    [1, 1, 1, 1, 1],
  ]
  hand_type =
    (
      hand[:hand]
        .each_char
        .each_with_object(Hash.new(0)) do |caractere, occurrences|
          occurrences[caractere] += 1
        end
    )

  if rule_part_2
    if hand_type.include?("J") && hand_type.length > 1
      nb_J = hand_type["J"]
      hand_type.delete("J")
      hand_type = hand_type.sort_by { |cle, valeur| valeur }.to_h
      hand_type[hand_type.keys.last] = hand_type[hand_type.keys.last] + nb_J

      return hand[:type] = types.index(hand_type.values.sort)
    end
  end

  hand[:type] = types.index(hand_type.values.sort)
end

hands.each { |hand| detect_type(hand) }

weight = {
  "J" => 1,
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "7" => 7,
  "8" => 8,
  "9" => 9,
  "T" => 10,
  "J" => 11,
  "Q" => 12,
  "K" => 13,
  "A" => 14,
}

resultat1 = 0
i = 1
grp_hands = hands.group_by { |el| el[:type] }.sort.reverse.to_h
grp_hands.each do |_, hands|
  donnees_triees =
    hands.sort_by do |item|
      item[:hand].chars.map { |caractere| weight[caractere] }
    end

  donnees_triees.each do |hand|
    resultat1 += hand[:bid].to_i * i
    i += 1
  end
end
puts resultat1
