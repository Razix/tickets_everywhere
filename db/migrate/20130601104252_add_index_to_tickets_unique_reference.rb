class AddIndexToTicketsUniqueReference < ActiveRecord::Migration
  def change
    add_index :tickets, :unique_reference, unique: true
  end
end
