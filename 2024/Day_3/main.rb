PATTERN =  /(?<calc>mul\((?<a>[0-9]{1,3}),(?<b>[0-9]{1,3})\))|(?<do>do\(\))|(?<dont>don't\(\))/



DATA = File.open("data").read

tt = 0

DATA.scan(PATTERN) do |match|
  tt += match[1].to_i * match[2].to_i
end

puts tt

tt = 0

pass = false
DATA.scan(PATTERN) do |match|

  pass = false if match[3] # do
  pass = true if match[4] # dont
  next if pass

  tt += match[1].to_i * match[2].to_i
end

puts tt
