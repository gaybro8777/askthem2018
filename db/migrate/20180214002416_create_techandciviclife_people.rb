class CreateTechandciviclifePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_people do |t|
      t.text :internal_id
      t.text :name
      t.timestamps
    end
    add_index(:techandciviclife_people, :internal_id, unique: true)
  end
end
