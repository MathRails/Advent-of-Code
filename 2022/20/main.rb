file = File.open('input.txt')

input = file.read.split("\n").map(&:to_i)

def solution(nums, key = 1, cycles = 1)
  list_of_numbers =
    nums.map.with_index { |value, index| { id: index, value: value * key } }
  cycles.times do
    nums.length.times do |t|
      last_index = list_of_numbers.index { |el| el[:id] == t }
      number = list_of_numbers.delete_at(last_index)

      new_index = (last_index + number[:value]) % list_of_numbers.length
      list_of_numbers.insert(new_index, number)
    end
  end

  zero_index = list_of_numbers.index { |el| el if el[:value] == 0 }
  steps = [1000, 2000, 3000]

  return(
    steps.sum do |coord|
      list_of_numbers[(zero_index + coord) % list_of_numbers.length][:value]
    end
  )
end

KEY = 811_589_153
puts "Solution 1 : #{solution(input)}"
puts "Solution 2 : #{solution(input, KEY, 10)}"
