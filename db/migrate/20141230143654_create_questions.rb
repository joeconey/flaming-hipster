class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :name
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :users
    add_index :questions, [:user_id, :created_at]
  end
end
