class AddAgentFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string # STI
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :agent_code, :integer
    add_column :users, :office_phone, :string
    add_column :users, :cell_phone, :string
    add_column :users, :image, :string
    add_column :users, :office_id, :integer # references
    
    add_index :users, :agent_code, :unique => true
  end
end
