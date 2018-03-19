class CreateTechandciviclifeCandidateContests < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_candidate_contests do |t|
      t.text :internal_id, null: false
      t.text :name, null: false
      t.text :candidate_selections, array: true, null: false, default: []
      t.text :electoral_district_id, null: false
      t.text :office_id, null: false
      t.timestamps
    end
    add_index(:techandciviclife_candidate_contests, :internal_id, unique: true)
  end
end
