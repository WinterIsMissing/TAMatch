class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :course
      t.string :label
      t.references :applicant, foreign_key: true

      t.timestamps
    end
  end
end
