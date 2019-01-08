require 'csv'    

class Course
  def estimate_assistants(student_num)
    return student_num.to_i / 60 + 1
  end
  
  def initialize(name, professor, time, student_num)
    @name = name
    @times = [time]
    @professor = professor
    @assistant_count = estimate_assistants(student_num)
  end
  
  def add_time(time)
    @times.push(time)
  end
  
  def to_s
    "CSCE #{@name} with #{@professor} and #{assistant_count} assistants"
  end
end

csv_text = File.read('./test/classbook.csv')
csv = CSV.parse(csv_text)

courses = []
csv.each do |line|
  student_num = line.fetch(10, nil)
  time = "#{line.fetch(8, "")} #{line.fetch(9, "")}"
  next if time.blank?
  unless student_num.nil?
    name = "#{line.fetch(3, "")}-#{line.fetch(4, "")}"
    courses.push(Course.new(name, line.fetch(13,nil), time, student_num))
  else
    courses[-1].add_time(time)
  end
  puts courses[-1]
end

      