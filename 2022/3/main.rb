file = File.open('input.txt')
file_content = file.read
PRIORITIES = {}
score1 = 0
score2 = 0

def define_priorities()
  value = 1
  ('a'..'z').each do |l|
    PRIORITIES[l] = value
    value += 1
  end

  ('A'..'Z').each do |l|
    PRIORITIES[l] = value
    value += 1
  end
end

define_priorities

def rule1(line)
  c1, c2 = line.strip.split('').each_slice(line.length / 2).to_a
  PRIORITIES[(c1.select { |letter| c2.include? letter })[0]]
end

def rule2(group)
  temp = 0
  group
    .join
    .split('')
    .uniq
    .each do |letter|
      (group[0].include? letter) && (group[1].include? letter) &&
        (group[2].include? letter) ?
        temp += PRIORITIES[letter] :
        0
    end
  temp
end

file_content.split("\n") { |line| score1 += rule1(line) }

file_content
  .split("\n")
  .each_slice(3)
  .to_a
  .each { |group| score2 += rule2(group) }

puts "Rule 1 : #{score1}"
puts "Rule 2 : #{score2}"
