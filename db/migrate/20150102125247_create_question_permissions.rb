class CreateQuestionPermissions < ActiveRecord::Migration
  def change
    create_table :question_permissions do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :question_permissions, :question_id
    add_index :question_permissions, :user_id
    add_index :question_permissions, [:question_id, :user_id], unique: true
  end
end
