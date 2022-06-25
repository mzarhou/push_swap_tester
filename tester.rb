#! /usr/bin/ruby

n = ARGV[0].to_i
nb_tests = ARGV[1].to_i
push_swap_path = "..".chomp('/')

if File.file?("#{push_swap_path}/push_swap") == false then
	abort("invalid push_swap path")
end
if n <= 0 || nb_tests <= 0 then
    abort("invalid arguments")
end

puts "test #{n} values --- #{nb_tests} #{nb_tests == 1 ? 'test' : 'tests'}\n\n"

nb_tests.times do
	result = (1..n).to_a.shuffle.join(" ")
	instructions = `./#{push_swap_path}/push_swap #{result}`
	instructions_size = instructions.delete(" ").split("\n").size
	checker_status = `./#{push_swap_path}/push_swap #{result} | ./#{push_swap_path}/checker_Mac #{result}`
	puts checker_status.chomp + " => " + instructions_size.to_s
end
