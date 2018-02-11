class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.timestamps
    end
    add_reference :questions, :contest, null: false, foreign_key: true
  end
end
