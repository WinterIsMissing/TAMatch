class CreateInstructorPreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :instructor_preferences do |t|
      t.text :preferences
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
