resultat1 = 0

# id_card => nb copy
card_owned = Hash.new(0)

File
  .open("data")
  .readlines
  .each do |line|
    cards, numbers = line.split(":")
    id_card = cards.split(" ")[1].to_i
    main, winning = numbers.split("|")
    main = main.split(/\s+/).reject(&:empty?)
    winning = winning.split(/\s+/).reject(&:empty?)

    res = main & winning
    if !res.empty?
      if res.length > 1
        resultat1 += (2**(res.length - 1))
      else
        resultat1 += 1
      end
    end

    card_owned[id_card] += 1 || 1

    ((id_card + 1)...(id_card + res.length + 1)).each do |nb|
      card_owned[nb] += card_owned[id_card]
    end
  end

puts resultat1
puts card_owned.values.reduce(:+)
