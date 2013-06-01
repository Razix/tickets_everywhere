class AddColumnCommentsAdminId < ActiveRecord::Migration
  def up
    add_column :comments, :admin_id, :integer
  end

  def down
  end
end
