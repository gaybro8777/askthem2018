class CreateTechandciviclifeCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_candidates do |t|
      t.text :internal_id, null: false
      t.text :person_id, null: false
      t.text :party_id
      t.text :name
      t.timestamps
    end
    add_index(:techandciviclife_candidates, :internal_id, unique: true)
  end
end
