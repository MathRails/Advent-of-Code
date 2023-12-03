resultat = 0

File
  .open("data")
  .readlines
  .each do |line|
    res = line.scan(/\d/)
    resultat += "#{res.first}#{res.last}".to_i
  end
puts resultat
