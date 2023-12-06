require "benchmark"

time_distance = Array.new
File
  .open("data")
  .readlines
  .each { |line| time_distance << line.scan(/(\d+)/).flatten.map(&:to_i) }

def calc_race_win(time_distance)
  res = []
  time_distance.transpose.each do |race|
    nb = 0
    (1..(race[0])).each do |t|
      dst = (race[0] - t) * t
      nb += 1 if dst > race[1]
    end
    res << nb
  end
  res
end

# Solution 1
puts calc_race_win(time_distance).reduce(&:*)

time = time_distance[0].join("").to_i
dist = time_distance[1].join("").to_i

# Solution 2 - non opti
Benchmark.bm(20) do |bm|
  bm.report("Solution 2 - non opti:") do
    calc_race_win([[time], [dist]]).reduce(&:*)
  end

  # Solution 2 - opti
  bm.report("Solution 2 - opti:") do
    content = File.open("data").readlines

    x = 0
    (0..time).each do |t|
      if t * (time - t) > dist
        x = t
        break
      end
    end

    y = 0
    (time).downto(0) do |t|
      if t * (time - t) > dist
        y = t
        break
      end
    end
  end
end

=begin
                           user     system      total        real
Solution 2 - non opti:  3.995637   0.001175   3.996812 (  4.015734)
Solution 2 - opti:     0.793084   0.000125   0.793209 (  0.794136)
=end
