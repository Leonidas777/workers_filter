require 'benchmark'

require './worker.rb'
require './search_workers_service.rb'

workers = (1..10_000_000).collect do |number|
  age    = rand(0..Worker::MAX_AGE)
  salary = rand(0..Worker::MAX_SALARY)
  height = rand(0..Worker::MAX_HEIGHT)
  weight = rand(0..Worker::MAX_WEIGHT)

  new_worker = Worker.new(age, salary, height, weight)

  puts "#{number}) " + new_worker.to_s

  new_worker
end

puts 'Hit any key to filter all workers:'
gets

query = { age:    { from: 10, to: 30 },
          salary: { from: 200_000.0, to: 600_000.0 },
          height: { from: 20, to: 50 },
          weight: { from: 50, to: 80 }  }

filtered_workers = []

puts 'Used resources:'
Benchmark.bm(18) do |x|
  x.report('Filtering workers:') { filtered_workers = SearchWorkersService.search_by(workers, query) }
end

puts 'Filtered workers:'
filtered_workers.each do |worker|
  puts worker
end

puts "Number of filtered workers: #{filtered_workers.size}"
