class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.text :primary_name
      t.integer :contest_id
      t.text :primary_party
      t.text :secondary_name
      t.text :secondary_party
      t.text :candidate_selection_id
      t.timestamps
    end
  end
end
