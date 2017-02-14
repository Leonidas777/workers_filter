class Worker
  MAX_AGE = 100
  MAX_SALARY = 10_000_000.0
  MAX_HEIGHT = 200
  MAX_WEIGHT = 200

  attr_reader :age, :salary, :height, :weight

  def initialize(age, salary, height, weight)
    @age = age
    @salary = salary
    @height = height
    @weight = weight
  end

  def to_s
    "Worker => age: #{@age}, salary: #{@salary}, height: #{@height}, weight: #{@weight}"
  end
end
