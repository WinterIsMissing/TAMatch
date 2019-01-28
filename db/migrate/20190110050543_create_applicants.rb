class CreateApplicants < ActiveRecord::Migration[5.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :degree_program
      t.boolean :isTA
      t.boolean :isGrader
      t.boolean :isSG
      t.text :advisor, default: "none"
      t.integer :yearsGraduate, default: 0
      t.text :preference_list, array: true, default: []
      t.text :preferences, array: true, default: []
      t.text :antipref, array: true, default: []
      t.text :indifferent, array: true, default: []
      

      t.timestamps
    end
  end
end
