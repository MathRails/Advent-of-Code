file = File.open('input.txt')

list_pair = file.read.squeeze("\n").split("\n").map { |l| eval(l) }

sum_indices = 0

# def compare_array(left, right)
#   resultat = 1
#   return -1 if right.nil?
#   left_a = left.class != Array ? left.digits.reverse : left
#   right_a = right.class != Array ? right.digits.reverse : right

#   #   puts "Left_A #{left_a}"
#   #   puts "Rigth_A #{right_a}"

#   left_a.each_with_index do |val, i|
#     if val.class == Array || right_a[i].class == Array
#       resultat = compare_array(val, right_a[i])
#     else
#       return -1 if right_a.empty?
#       puts "Compare #{left} > #{right} "
#       puts "Compare #{val} > #{right_a[i]} = #{(val > right_a[i])}"
#       resultat = -1 if val > (right_a.class == Array ? right_a[i] : right_a)
#     end

#     if right_a.length == i + 1 && left_a.length > right_a.length &&
#          right.class == Array
#       return -1
#     end

#     return resultat if resultat == -1
#     return resultat if i == left_a.length - 1
#     return resultat if i == right_a.length - 1
#   end

#   resultat
# end

def compare_array(left, right)
  if left.is_a?(Integer) && right.is_a?(Integer)
    return -1 if left < right
    return 1 if left > right
    return 0
  elsif left.is_a?(Integer)
    return compare_array([left], right)
  elsif right.is_a?(Integer)
    return compare_array(left, [right])
  end

  return 0 if left.empty? && right.empty?
  return -1 if left.empty?
  return 1 if right.empty?

  res = compare_array(left.first, right.first)
  return res if res != 0

  compare_array(left[1..], right[1..])
end

list_pair
  .each_slice(2)
  .each_with_index do |pair, i|
    left = pair[0]
    right = pair[1]
    sum_indices += (i + 1) if compare_array(left, right) == -1
  end

puts "Resultat : #{sum_indices}"

list_pair << [[2]]
list_pair << [[6]]
list_sort = list_pair.sort { |b, a| compare_array(b, a) }

position_a = list_sort.index([[2]]) + 1
position_b = list_sort.index([[6]]) + 1

puts position_a * position_b
