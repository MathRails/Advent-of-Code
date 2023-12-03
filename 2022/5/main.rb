file = File.open('input.txt')

stacks = [
  %w[V C D R Z G B W],
  %w[G W F C B S T V],
  %w[C B S N W],
  %w[Q G M N J V C P],
  %w[T S L F D H B],
  %w[J V T W M N],
  %w[P F L C S T G],
  %w[B D Z],
  %w[M N Z W],
]

stacks2 = [
  %w[V C D R Z G B W],
  %w[G W F C B S T V],
  %w[C B S N W],
  %w[Q G M N J V C P],
  %w[T S L F D H B],
  %w[J V T W M N],
  %w[P F L C S T G],
  %w[B D Z],
  %w[M N Z W],
]

file_content = file.read
file_content = file_content.split("\n")
file_content.shift(10)

file_content.each do |line|
  nb, id_stack_src, id_stack_dst =
    line.split(' ').select { |data| Integer(data, exception: false) }
  stacks[id_stack_dst.to_i - 1].concat(
    stacks[id_stack_src.to_i - 1].pop(nb.to_i).reverse,
  )
  stacks2[id_stack_dst.to_i - 1].concat(
    stacks2[id_stack_src.to_i - 1].pop(nb.to_i),
  )
end
puts stacks.map { |stack| stack[-1] }.join
puts stacks2.map { |stack| stack[-1] }.join
