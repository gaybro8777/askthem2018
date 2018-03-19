class CreateTechandciviclifeParties < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_parties do |t|
      t.text "internal_id"
      t.text "name"
      t.timestamps
    end

    add_index(:techandciviclife_parties, :internal_id, unique: true)
    add_index(:techandciviclife_parties, :name, unique: true)
  end
end
