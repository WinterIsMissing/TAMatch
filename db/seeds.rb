# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# case Rails.env
# when 'test'

    # Admin levels have been mixed up and changes, do not rely on sections headers
    #Admin
    User.create(
        {
            fullname: 'Adam McAdmin', username: 'Adam McAdmin', email: 'test_a@x.x', auth_level: 'admin',
            login_token: 'test_a', token_generated_at: Time.now.utc.to_s
        })
        
    #Instructor
    User.create(
        {
            fullname: 'Ignacio Instruc', username: 'Ignacio Instruc', email: 'test_i@x.x', auth_level: 'instructor',
            login_token: 'test_i', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Rory Rotinuc', username: 'Rory Rotinuc', email: 'test_i2@x.x', auth_level: 'instructor',
            login_token: 'test_i2', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Cecilia Coroutin', username: 'Cecilia Coroutin', email: 'test_i3@x.x', auth_level: 'instructor',
            login_token: 'test_i3', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Oreia Oritin', username: 'Oreia Oritin', email: 'test_i4@x.x', auth_level: 'instructor',
            login_token: 'test_i4', token_generated_at: Time.now.utc.to_s
        })
        
        
    
    #Student
    User.create(
        {
            fullname: 'Sander Sudent', username: 'Sander Sudent', email: 'test_s@x.x', auth_level: 'student',
            login_token: 'test_s', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Sudan Summit', username: 'Sudan Summit', email: 'test_s1@x.x', auth_level: 'student',
            login_token: 'test_s1', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Smitty Sunted', username: 'Smitty Sunted', email: 'test_s2@x.x', auth_level: 'student',
            login_token: 'test_s2', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Danny Fenton', username: 'Danny Fenton', email: 'test_s3@x.x', auth_level: 'student',
            login_token: 'test_s3', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Alfreds Futterkiste', username: 'Alfreds Futterkiste', email: 'test_s4@x.x', auth_level: 'student',
            login_token: 'test_s4', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Ernst Handel', username: 'Ernst Handel', email: 'test_s5@x.x', auth_level: 'student',
            login_token: 'test_s5', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Edmund Kee', username: 'Edmund Kee', email: 'ksj.edmund@gmail.com', auth_level: 'admin',
            login_token: 'bige', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Mackenzie Ford', username: 'Mackenzie Ford', email: 'kenzford8@gmail.com', auth_level: 'admin',
            login_token: 'mackenzie', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Ivan Delgado', username: 'Ivan Delgado', email: 'htxdelgado1@tamu.edu', auth_level: 'instructor',
            login_token: 'ivan', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Benjamin Wong', username: 'Benjamin Wong', email: 'test_sb@x.x', auth_level: 'student',
            login_token: 'ben', token_generated_at: Time.now.utc.to_s
        })
    
# end
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
  
  antis = antis.split(/, /).map(&:strip)
  prefs = prefs.split(/, /).map(&:strip)
  indif = indif.split(/, /).map(&:strip)
  
  antis = antis - prefs
  indif = indif - prefs - antis
  pref_list = prefs.append(indif)
  pref_list.flatten!
  
  apps.push(
    Applicant.create({
      :name=> "Sample Student #{line["name"]}", 
      :email=> "sample.student.#{line["name"]}@tamu.edu",
      :degree_program=> line["degreeProgram"],
      :isTA=> line["isTA?"],
      :isGrader=> line["isGrader?"],
      :isSG=> line["isSG?"],
      :preference_list=> pref_list.to_s,
      :preferences=> prefs,
      :antipref=> antis.to_s,
      :indifferent=> indif.to_s 
      }))
end