# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'  

csv_text = File.read('./test/coursebook_simple.csv')
csv = CSV.parse(csv_text, :headers=>true)

courses = []
csv.each do |line|
  student_num = line["students"].to_i
  name = line["course"]
  info = "#{line["title"]} #{line["info"]}"
  courses.push(
      Course.create({
      :name=> name, 
      :student_count=> student_num,
      :course_info=> info}))
end

#Course.import(courses)
