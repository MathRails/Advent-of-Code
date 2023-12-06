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

puts calc_race_win(time_distance).reduce(&:*)
puts calc_race_win([[60_947_882], [475_213_810_151_650]]).reduce(&:*)
