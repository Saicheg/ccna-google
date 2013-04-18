class RemoveRightColumn < ActiveRecord::Migration
  def up
    remove_column :answers, :right
  end

  def down
    add_column :answers, :right, :boolean
  end
end
