require 'rails_helper'

RSpec.describe Course, type: :model do
  valid_args = {
    :name=>"105",
    :student_count=>100,
    :course_info=>"this is some info"
  }
  bad_args = {
    :name=>nil,
    :student_count=>100,
    :course_info=>"this is some info including phrase capstone"
  }
  it "is valid with valid attributes" do
    expect(Course.new(valid_args)).to be_valid
  end
  it "is not valid without a name" do
    course = Course.new(bad_args)
    expect(course).to_not be_valid
  end
  it "gives one TA to capstone" do
    course = Course.new(valid_args)
    expect course.ta_count == 1
  end
  it "prints to string" do
    course = Course.new(valid_args) 
    expect course.to_s =~ /CSCE 105/
  end
end
