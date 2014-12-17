class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.references :company
      
      t.string :office_type, :null => false, :limit => 32
      t.string :mls_id, :null => false, :limit => 8
      t.string :name, :null => false
      t.string :phone, :limit => 14
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state, :limit => 2
      t.string :zipcode, :limit => 16
      t.string :email
      t.string :office_logo
      t.string :office_image

      t.timestamps
    end
    
    add_index :offices, :mls_id, :unique => true
  end
end
