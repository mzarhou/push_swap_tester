#! /usr/bin/ruby

n = ARGV[0].to_i
nb_tests = ARGV[1].to_i
push_swap_path = "..".chomp('/')
sizes_hash = {}

#handling signals
["QUIT", "INT"].each { |signal|
	Signal.trap(signal) do
		abort "\n"
	end
}

if File.file?("#{push_swap_path}/push_swap") == false then
	abort("invalid push_swap path")
end
if n <= 0 || nb_tests <= 0 then
    abort("invalid arguments")
end

puts "test #{n} values --- #{nb_tests} #{nb_tests == 1 ? 'test' : 'tests'}\n\n"

nb_tests.times do
	random_numbers = (1..n).to_a.shuffle.join(" ")
	instructions = `./#{push_swap_path}/push_swap #{random_numbers}`
	instructions_size = instructions.split("\n").size
	# mapping number of instruction to associated random numbers
	sizes_hash[instructions_size] = random_numbers
	checker_status = `./#{push_swap_path}/push_swap #{random_numbers} | ./checker_Mac #{random_numbers}`
	puts checker_status.chomp + " => " + instructions_size.to_s
end

# list of instructions sizes of each test
sizes_list = sizes_hash.keys
max = sizes_list.max
avg = sizes_list.sum / sizes_list.size

puts "\n\nBenchmarks:"
puts "min => " + sizes_list.min.to_s
puts "max => " + max.to_s
puts "avg => " + avg.to_s

puts "\n\nFind worst case numbers in log file\n\n"

File.open("log", "w"){|f| f.write sizes_hash[max]}
