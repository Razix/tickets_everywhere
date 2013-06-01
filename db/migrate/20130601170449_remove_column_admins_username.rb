class RemoveColumnAdminsUsername < ActiveRecord::Migration
  def up
    remove_column :admins, :username
  end

  def down
  end
end
