class Course < ApplicationRecord
  validates_presence_of :name, :ta_count, :grader_count
  
  attr_accessor :name, :student_count, :course_info, :ta_count, :grader_count
  
  def self.primary_key
    @name
  end
  
  def estimate_assistants(student_num, course_info)
    # "a good measure is 60=1 TA, 90-100=1 TA + 1 grader. Seminars get nothing. Capstones get 1 TA"
    @grader_count = 0
    @ta_count = 0
    if course_info =~ /capstone/i 
      @ta_count = 1
    elsif  course_info =~ /((\bseminar\b)|(\bresearch\b)|(\bdirected studies\b))/i
      #return without doing anything else
      #this is a seminar, research, or directed study
    else
      @ta_count = student_num.to_i / 60 
      r = student_num.to_i.modulo(60)
      @grader_count += 1 if r.between?(30,40)
      @ta_count += 1 if r > 40  
    end
  end
  
  def initialize(kargs)
    @name = kargs[:name]
    @student_count = kargs[:student_count]
    @course_info = kargs[:course_info]
    estimate_assistants(@student_count, @course_info)
  end

  def to_s
    "CSCE #{@name}: #{@ta_count} TAs, #{@grader_count} graders, #{@student_count} students"
  end
end