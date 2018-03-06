class CreateTechandciviclifePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :techandciviclife_people do |t|

      t.timestamps
    end
  end
end
