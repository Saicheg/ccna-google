class ChangeRightType < ActiveRecord::Migration
  def up
    add_column :answers, :correct, :boolean
  end

  def down
    remove_column :answers, :correct
  end
end
