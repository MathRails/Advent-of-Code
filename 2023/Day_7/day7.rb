hands = Array.new

File
  .open("test")
  .readlines
  .each do |line|
    _hand, _bid = line.split(" ")
    hands << { hand: _hand, bid: _bid, nb_wins: 0 }
  end

def detect_win_type(hand_l, hand_r)
  # -1 hand_l win
  # 1 hand_r win
  # 0 ex aequo
  types = [
    [5],
    [1, 4],
    [2, 3],
    [1, 1, 3],
    [1, 2, 2],
    [1, 1, 1, 2],
    [1, 1, 1, 1, 1],
  ]
  hand_l_type =
    (
      hand_l
        .each_char
        .each_with_object(Hash.new(0)) do |caractere, occurrences|
          occurrences[caractere] += 1
        end
    ).values.sort

  hand_r_type =
    (
      hand_r
        .each_char
        .each_with_object(Hash.new(0)) do |caractere, occurrences|
          occurrences[caractere] += 1
        end
    ).values.sort

  return -1 if types.find_index(hand_l_type) < types.find_index(hand_r_type)
  return 1 if types.find_index(hand_l_type) > types.find_index(hand_r_type)
  return 0
end

def detect_win_card(hand_l, hand_r)
  weight = %w[2 3 4 5 6 7 8 9 T J Q K A]
  hand_l.each_char do |hand_l_card|
    hand_r.each_char do |hand_r_card|
      next if hand_l_card == hand_r_card

      if weight.index(hand_l_card) > weight.index(hand_r_card)
        return -1
      else
        return 1
      end
    end
  end
end

hands.each_with_index do |hand_l, i_l|
  hands.each_with_index do |hand_r, i_r|
    next if i_l == i_r

    type_game = detect_win_type(hand_l[:hand], hand_r[:hand])
    hand_l[:nb_wins] += 1 if type_game == -1
    hand_r[:nb_wins] += 1 if type_game == 1

    next unless type_game == 0

    card_win = detect_win_card(hand_l[:hand], hand_r[:hand])
    hand_l[:nb_wins] += 1 if type_game == -1
    hand_r[:nb_wins] += 1 if type_game == 1
  end
end

puts hands
