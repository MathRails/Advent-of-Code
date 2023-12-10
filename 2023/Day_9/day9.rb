dataset =
  File.open("data").readlines.map { |line| [line.strip.split(" ").map(&:to_i)] }

def extrapolate(data, sens)
  until data[-1].each_cons(2).all? { |a, b| (a - b) == 0 }
    new_line = Array.new
    data[-1].each_cons(2) { |a, b| new_line << (b - a) }
    data.push(new_line)
  end

  data.push(Array.new(data[-1].length() - 1, 0))

  data.reverse_each.with_index do |element, index|
    next if index == 0

    if sens
      element.push(element[-1] + data[data.length - index][-1])
    else
      element.unshift(element[0] - data[data.length - index][0])
    end
  end
  sens ? data[0][-1] : data[0][0]
end

res = dataset.map { |data| extrapolate(data, true) }
puts res.reduce(:+)
res = dataset.map { |data| extrapolate(data, false) }
puts res.reduce(:+)
