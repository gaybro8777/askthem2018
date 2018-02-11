class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|

      t.integer :user_id
      t.integer :question_id
      t.timestamps
    end

    add_index :votes, [:user_id, :question_id], unique: true
    add_index :votes, :question_id
  end
end
