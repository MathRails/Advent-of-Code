map = File.readlines("data").map { |line| line.strip.split(" ").map(&:to_i) }

# Part 1
result = map.transpose.map { |array| array.sort }
subtracted_result = result[0].zip(result[1]).map { |a, b| (a - b).abs }
total_sum = subtracted_result.sum
puts total_sum

# Part 2


frequency_map = result[1].tally
tt = 0

result[0].each do |el|
  tt += (frequency_map[el] || 0) * el
end

p tt
