file = File.open('input.txt')
file_content = file.read

counter = 0
counter2 = 0

file_content
  .split("\n")
  .each do |pair|
    p1, p2 = pair.split(',')
    b1_min, b1_max = p1.split('-').map(&:to_i)
    b2_min, b2_max = p2.split('-').map(&:to_i)

    if (
         (b1_min..b1_max).include?(b2_min) && (b1_min..b1_max).include?(b2_max)
       ) ||
         (
           (b2_min..b2_max).include?(b1_min) &&
             (b2_min..b2_max).include?(b1_max)
         )
      counter += 1
    end

    if (
         (b1_min..b1_max).include?(b2_min) || (b1_min..b1_max).include?(b2_max)
       ) ||
         (
           (b2_min..b2_max).include?(b1_min) ||
             (b2_min..b2_max).include?(b1_max)
         )
      counter2 += 1
    end
  end

puts counter
puts counter2
