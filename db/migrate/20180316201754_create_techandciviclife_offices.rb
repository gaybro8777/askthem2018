class CreateTechandciviclifeOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_offices do |t|

      t.text :internal_id, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.text :electoral_district_id, null: false
      t.timestamps
    end

    add_index(:techandciviclife_offices, :internal_id, unique: true)
  end
end
