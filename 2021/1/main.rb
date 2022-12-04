file = File.open("input.txt")
file_content = file.read

previous = nil
previous2 = nil
counter = 0
counter2 = 0

arr = file_content.split("\n").map(&:to_i)

arr.each do |line|
    if previous.nil?
        previous = line
    end

    if line> previous 
        counter = counter + 1
    end
    previous = line
end

(0..arr.length-3).each do |n|
    if previous2.nil?
        previous2 = arr[n] + arr[n+1] + arr[n+2]
    end

    current = arr[n] + arr[n+1] + arr[n+2]
    if current > previous2
        counter2 = counter2 + 1
    end
    previous2 = current
end

puts counter
puts counter2