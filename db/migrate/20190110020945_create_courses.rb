class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :ta_count
      t.integer :grader_count
      t.integer :student_count
      t.text :course_info

      t.timestamps
    end
  end
end