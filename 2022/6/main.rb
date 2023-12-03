file = File.open('input.txt')
file_content = file.read.split('')

key = []
search4 = true
search14 = true

file_content.each_index do |x|
  if (key.length < 4 && search4) || (key.length < 14 && search14 && !search4)
    key.append(file_content[x])
  end

  key.shift if key.uniq != key

  if key.length == 4 && search4
    puts "Key 4 : #{key}"
    puts "Position 4 : #{x + 1}"
    search4 = false
  end

  if key.length == 14 && search14
    puts "Key 14 : #{key}"
    puts "Position 14 : #{x + 1}"
    search14 = false
  end
end
