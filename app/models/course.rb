class Course < ApplicationRecord
  validates_presence_of :name
  
   def self.primary_key
     @name
   end
  
  def estimate_assistants(student_num, course_info)
    # "a good measure is 60=1 TA, 90-100=1 TA + 1 grader. Seminars get nothing. Capstones get 1 TA"
    self.grader_count = 0
    self.ta_count = 0
    if course_info =~ /capstone/i 
      self.ta_count = 1
    elsif  course_info =~ /((\bseminar\b)|(\bresearch\b)|(\bdirected studies\b))/i
      #return without doing anything else
      #this is a seminar, research, or directed study
    else
      self.ta_count = student_num.to_i / 60 
      r = student_num.to_i.modulo(60)
      self.grader_count += 1 if r.between?(30,40)
      self.ta_count += 1 if r > 40  
    end
  end
  
   after_initialize do |course|
       
     estimate_assistants(course.student_count, course.course_info)
   end

  def to_s
    "CSCE #{self.name}: #{self.ta_count} TAs, #{self.grader_count} graders, #{self.student_count} students"
  end
end