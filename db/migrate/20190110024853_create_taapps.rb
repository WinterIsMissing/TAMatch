class CreateTaapps < ActiveRecord::Migration[5.0]
  def change
    create_table :taapps do |t|
      t.string :degreeProgram
      t.boolean :isTA
      t.boolean :isGrader
      t.boolean :isSG
      t.text :pref, array: true, default: []
      t.text :indifferent, array: true, default: []
      t.text :antipref, array: true, default: []

      t.timestamps
    end
  end
end
