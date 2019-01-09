require 'csv'  
require 'set'

class Course
  def estimate_assistants(student_num, course_info)
    # "a good measure is 60=1 TA, 90-100=1 TA + 1 grader. Seminars get nothing. Capstones get 1 TA"
    @grader_count = 0
    @ta_count = 0
    if course_info =~ /capstone/i 
      @ta_count = 1
      return
    end
    return if course_info =~ /((\bseminar\b)|(\bresearch\b)|(\bdirected studies\b))/i
    @ta_count = student_num.to_i / 60 
    r = student_num.to_i.modulo(60)
    @grader_count += 1 if r.between?(30,40)
    @ta_count += 1 if r > 40  
  end
  
  def initialize(name, student_num, course_info)
    @name = name
    @student_count = student_num
    @course_info = course_info
    estimate_assistants(student_num, course_info)
  end

  def to_s
    "CSCE #{@name}: #{@ta_count} TAs, #{@grader_count} graders, #{@student_count} students"
  end
end

csv_text = File.read('./test/coursebook_simple.csv')
csv = CSV.parse(csv_text, :headers=>true)

courses = []
csv.each do |line|
  student_num = line["students"]
  name = line["course"]
  info = "#{line["title"]} #{line["info"]}"
  courses.push(Course.new(name, student_num, info))
end

courses.each {|x| puts x}