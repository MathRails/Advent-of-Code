file = File.open('input.txt')
folder_sizes = Hash.new(0)
file
  .readlines
  .map(&:split)
  .each_with_object([]) do |line, arbo|
    case line
    in %w[$ cd ..]
      arbo.pop
    in ['$', 'cd', folder]
      arbo.push folder
    in [size, file]
      if size.match?(/^\d+$/)
        arbo.reduce('') do |j, i|
          folder_sizes[j += i] += size.to_i
          j
        end
      end
    end
  end

total_disk = 70_000_000
space_necessary = 30_000_000
puts folder_sizes.values.select { |i| i <= 100_000 }.sum
puts folder_sizes
       .values
       .select { |i| i >= folder_sizes['/'] - (total_disk - space_necessary) }
       .min
