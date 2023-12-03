file = File.open("input.txt")
file_content = file.read

previous = nil
previous2 = nil
counter = 0
counter2 = 0

arr = file_content.split("\n").map(&:to_i)

arr.each do |line|
  previous = line if previous.nil?

  counter = counter + 1 if line > previous
  previous = line
end

(0..arr.length - 3).each do |n|
  previous2 = arr[n] + arr[n + 1] + arr[n + 2] if previous2.nil?

  current = arr[n] + arr[n + 1] + arr[n + 2]
  counter2 = counter2 + 1 if current > previous2
  previous2 = current
end

puts counter
puts counter2
