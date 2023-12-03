PATTERN = Regexp.new(<<~REGEXP.strip)
Sensor at x=(?<s_x>\\d*), y=(?<s_y>\\d*): closest beacon is at x=(?<b_x>-?\\d*), y=(?<b_y>-?\\d*)
REGEXP

class Sensor
  @@sensors = Array.new

  attr_reader :distance_manhattan, :sensor_position, :beacon_position

  def initialize(pos_sensor, pos_beacon, y)
    @sensor_position = pos_sensor
    @beacon_position = pos_beacon
    @y = y

    @distance_manhattan = manhattan

    @@sensors << self
  end

  def self.sensors
    @@sensors
  end

  private

  def manhattan()
    (@sensor_position[1] - @beacon_position[1]).abs +
      (@sensor_position[0] - @beacon_position[0]).abs
  end
end

nb_Row = 2_000_000

File
  .read("input_test.txt")
  .split("\n")
  .each_with_object({}) do |definition, row|
    data = PATTERN.match(definition)

    pt_s = [data[:s_x].to_i, data[:s_y].to_i]
    pt_b = [data[:b_x].to_i, data[:b_y].to_i]

    Sensor.new(pt_s, pt_b, nb_Row)
  end

possibilities = Array.new

Sensor.sensors.each do |sensor|
  diff = sensor.distance_manhattan - (sensor.sensor_position[1] - nb_Row).abs

  next if (sensor.sensor_position[1] - nb_Row).abs > sensor.distance_manhattan

  coords = Array.new
  coords << sensor.sensor_position[0] + diff
  coords << sensor.sensor_position[0] - diff

  ((coords.min)..(coords.max)).each { |el| possibilities << el }
end

# Delete beacons positions
Sensor.sensors.each do |sensor|
  if sensor.beacon_position[1] == nb_Row
    possibilities.delete sensor.beacon_position[0]
  end
end

puts possibilities.uniq.length
