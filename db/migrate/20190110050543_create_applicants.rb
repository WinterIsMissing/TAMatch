class CreateApplicants < ActiveRecord::Migration[5.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :degree_program
      t.boolean :is_ta
      t.boolean :is_grader
      t.boolean :is_sg
      t.text :preference_list
      t.text :preferences
      t.text :antipref
      t.text :indifferent
      
      t.timestamps
    end
  end
end
