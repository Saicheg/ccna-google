class ChangeRightType < ActiveRecord::Migration
  def up
    change_column :answers, :right, :boolean
  end

  def down
    change_column :answers, :right, :text
  end
end
