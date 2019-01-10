class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.column :name,     :string, default: "Error"
      t.column :ta_count,  :integer, default: 0
      t.column :grader_count, :integer, default: 0
      t.column :student_count,  :integer, default: 0
      t.column :course_info,  :string, default: "No information"
    end
    
    #add_index :courses, :name
  end
end
