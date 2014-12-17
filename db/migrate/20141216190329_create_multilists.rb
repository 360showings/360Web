class CreateMultilists < ActiveRecord::Migration
  def change
    create_table :multilists do |t|
      t.string :name, :null => false
      t.string :state, :null => false, :limit => 2

      t.timestamps
    end
  end
end
