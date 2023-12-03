file = File.open('input.txt')
file_content = file.read
sep_cal_by_elf = file_content.split("\n\n")

cal_by_elf = []

sep_cal_by_elf.each { |elf| cal_by_elf << elf.split("\n").map(&:to_i).sum }
puts cal_by_elf.max #rep 1
puts cal_by_elf.sort.reverse.take(3).sum #rep 2
