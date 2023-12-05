seeds = Array.new
list_map = Hash.new

resultat1 = nil

File
  .open("data")
  .readlines
  .each do |line|
    next if line.strip().empty?

    if line.match(/^seeds:/)
      seeds = line.split(":")[1].split(" ").map(&:to_i)
    elsif line.match(/([a-zA-Z\-]+) map:/)
      list_map[$1] = Array.new
    else
      destination, source, length = line.split(" ").map(&:to_i)
      list_map[list_map.keys.last] << {
        dest: destination,
        src: source,
        lgth: length,
      }
    end
  end

def resultat1(seeds, maps)
  res = Hash.new
  seeds.each do |seed|
    find = seed
    maps.each do |_, map_ranges|
      map_ranges.each do |range|
        if find >= range[:src] && find <= range[:lgth] + range[:src]
          find = range[:dest] + (find - range[:src])
          break
        end
      end
    end
    res[seed] = find
  end
  res
end

def resultat2(seeds_range, maps)
  ranges = []
  res = Hash.new
  seeds_range.each do |seed_range|
    maps.each do |_, map_ranges|
      map_ranges.each do |map|
        is_in_range =
          seed_range[0] >= map[:src] &&
            (seed_range[0] + seed_range[1] - 1) <= map[:lgth] + map[:src]
        if is_in_range
          puts map
          new_range =
            (
              ([seed_range[0], map[:src]].max)..[
                map[:lgth] + map[:src],
                seed_range[1] + seed_range[0],
              ].min
            )
          puts new_range
          puts
          ranges << new_range
        end
      end
    end
  end
  ranges.uniq!
  ranges.each do |rng|
    puts rng
    #res = res.merge(resultat1(rng.to_a, maps))
  end

  res
end

puts resultat1(seeds, list_map).values.min

seeds_rng = Array.new
seeds.each_slice(2) { |el| seeds_rng << el }
puts
puts resultat2(seeds_rng, list_map).values.min
