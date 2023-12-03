file = File.open('input.txt')

WIN_PT = 6
EX_PT = 3

POINTS_STS = { 'X' => 0, 'Y' => 3, 'Z' => 6 }
POINTS = { 'A' => 1, 'B' => 2, 'C' => 3, 'X' => 1, 'Y' => 2, 'Z' => 3 }
WIN_LOOSE = {
  'A' => 'Z',
  'B' => 'X',
  'C' => 'Y',
  'X' => 'C',
  'Y' => 'A',
  'Z' => 'B',
}

score1 = 0
score2 = 0

def rule1(opponent, me)
  temp = 0
  temp += POINTS[me]

  if (me == 'X' && opponent == 'C') || (me == 'Y' && opponent == 'A') ||
       (me == 'Z' && opponent == 'B')
    temp += WIN_PT
  elsif (me == 'X' && opponent == 'A') || (me == 'Y' && opponent == 'B') ||
        (me == 'Z' && opponent == 'C')
    temp += EX_PT
  end

  temp
end

def rule2(col1, col2)
  temp = 0
  temp += POINTS_STS[col2]

  if col2 == 'Z'
    temp += POINTS[WIN_LOOSE.key(col1)]
  elsif col2 == 'Y'
    temp += POINTS[col1]
  else
    temp += POINTS[WIN_LOOSE[col1]]
  end
  temp
end

file.each do |line|
  opponent, me = line.split(' ')
  score1 += rule1(opponent, me)
  score2 += rule2(opponent, me)
end

puts score1
puts score2
