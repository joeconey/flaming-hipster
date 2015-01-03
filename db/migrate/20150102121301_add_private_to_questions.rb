class AddPrivateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :private, :boolean, default: false
  end
end
