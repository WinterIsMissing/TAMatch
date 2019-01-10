# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'  

csv_text = File.read('./app/assets/coursebook_simple.csv')
csv = CSV.parse(csv_text, :headers=>true)

arry = []
csv.each do |line|
  student_num = line["students"].to_i
  name = line["course"]
  info = "#{line["title"]} #{line["info"]}"
  arry.push(
      Course.create({
      :name=> name, 
      :student_count=> student_num,
      :course_info=> info}))
end

csv_text = File.read('./app/assets/Applicants_Spring_2019.csv')
csv = CSV.parse(csv_text, :headers=>true)

course_list = []
level_1 = []
level_2 = []
level_3 = []
level_4 = []
Course.find_each do |x|
  course_list.push(x.name)
  if x.name =~ /1[0-9][0-9]/
    level_1.push(x.name)
  elsif x.name =~ /2[0-9][0-9]/
    level_2.push(x.name)
  elsif x.name =~ /3[0-9][0-9]/
    level_3.push(x.name)
  elsif x.name =~ /4[0-9][0-9]/
    level_4.push(x.name)
  end
end

lvl_1_s = level_1.to_s.gsub(/[^0-9, ]/,"")
lvl_2_s = level_2.to_s.gsub(/[^0-9, ]/,"")
lvl_3_s = level_3.to_s.gsub(/[^0-9, ]/,"")
lvl_4_s = level_4.to_s.gsub(/[^0-9, ]/,"")

apps = []
csv.each do |line|
  
  pref_list = []
  prefs = line["preferences"]
  antis = line["antipref"]
  indif = line["indifferent"]
  prefs = ", " if prefs.nil?
  antis = ", " if antis.nil?
  indif = ", " if indif.nil?
  
  prefs.gsub!(/100/, lvl_1_s)
  prefs.gsub!(/200/, lvl_2_s)
  prefs.gsub!(/300/, lvl_3_s)
  prefs.gsub!(/400/, lvl_4_s)
  prefs.gsub!(/[^1-4][0-9][0-9], /, "")
  prefs.gsub!(/, [^1-4][0-9][0-9]/, "")
  
  antis.gsub!(/100/, lvl_1_s)
  antis.gsub!(/200/, lvl_2_s)
  antis.gsub!(/300/, lvl_3_s)
  antis.gsub!(/400/, lvl_4_s)
  antis.gsub!(/[^1-4][0-9][0-9], /, "")
  antis.gsub!(/, [^1-4][0-9][0-9]/, "")
  
  indif.gsub!(/400/, lvl_4_s)
  indif.gsub!(/300/, lvl_3_s)
  indif.gsub!(/200/, lvl_2_s)
  indif.gsub!(/100/, lvl_1_s)
  indif.gsub!(/[^1-4][0-9][0-9], /, "")
  indif.gsub!(/, [^1-4][0-9][0-9]/, "")
  
  antis = antis.split(/, /)
  prefs = prefs.split(/, /)
  indif = indif.split(/, /)
  
  antis = antis - prefs
  indif = indif - prefs - antis
  pref_list = prefs.append(indif)
  pref_list.flatten!
  
  apps.push(
    Applicant.create({
      :name=> "Sample Student #{line["name"]}", 
      :email=> line["email"],
      :degree_program=> line["degreeProgram"],
      :is_ta=> line["isTA?"],
      :is_grader=> line["isGrader?"],
      :is_sg=> line["isSG?"],
      :preference_list=> pref_list.to_s,
      :preferences=> prefs.to_s,
      :antipref=> antis.to_s,
      :indifferent=> indif.to_s 
      }))
end
