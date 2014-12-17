class CreateRealtors < ActiveRecord::Migration
  def change
    create_table :realtors do |t|
      t.references :multilist
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :agent_code
      t.string :office_code, :limit => 8
      t.string :email

      t.timestamps
    end
    
    add_index :realtors, [:multilist_id, :agent_code], :unique => true
  end
end
