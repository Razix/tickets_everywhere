class AddColumnToCommentsAdminId < ActiveRecord::Migration
  def change
    add_column :comments, :admin_id, :integer
  end
end
