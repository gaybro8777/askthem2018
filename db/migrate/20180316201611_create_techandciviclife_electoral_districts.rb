class CreateTechandciviclifeElectoralDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_electoral_districts do |t|

      t.text :internal_id, null: false
      t.text :name, null: false
      t.text :type, null: false
      t.timestamps
    end

    add_index(:techandciviclife_electoral_districts, :internal_id, unique: true)
  end
end
