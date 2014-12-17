class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :agent
      
      t.integer :mls_num, :null => false
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state, :limit => 2
      t.string :zipcode, :limit => 10

      t.timestamps
    end
  end
end
