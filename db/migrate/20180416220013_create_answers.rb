class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :candidate, null: false
      t.references :question, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
