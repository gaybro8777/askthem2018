class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :candidates, null: false
      t.references :questions, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
