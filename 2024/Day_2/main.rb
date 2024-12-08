DATA = File.open("sample").read.split("\n").map { |line| line.split(' ').map(&:to_i) }


def check_safe_report(report, part2)
  last_value = nil
  type = nil

  def is_safe?(report)
    last_value = nil
    type = nil

    report.each do |value|
      if last_value.nil?
        last_value = value
        next
      end

      if type.nil?
        type = (last_value > value) ? -1 : 1
      end

      diff = (last_value - value).abs

      if diff < 1 || diff > 3 || (type == -1 && value > last_value) || (type == 1 && value < last_value)
        return false
      end

      last_value = value
    end

    true
  end

  return is_safe?(report) unless part2

  (0...report.length).each do |i|
    new_report = report[0...i] + report[(i + 1)..-1]
    return true if is_safe?(new_report)
  end

  false
end


nb_safe_report_1 = 0
nb_safe_report_2 = 0

DATA.each do |report|
  nb_safe_report_1 +=1 if check_safe_report(report, false)
  nb_safe_report_2 +=1 if check_safe_report(report, true)
end

puts nb_safe_report_1
puts nb_safe_report_2
