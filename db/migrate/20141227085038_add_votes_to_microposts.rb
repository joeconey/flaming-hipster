class AddVotesToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :votes, :integer, default: 0
  end
end
