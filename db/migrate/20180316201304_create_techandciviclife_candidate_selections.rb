class CreateTechandciviclifeCandidateSelections < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_candidate_selections do |t|
      t.text :internal_id, null: false
      t.text :candidate_ids, array: true, null: false, default: []
      t.timestamps
    end

    add_index(:techandciviclife_candidate_selections, :internal_id, unique: true)
  end
end
