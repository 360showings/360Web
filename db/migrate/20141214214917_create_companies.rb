class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :null => false, :limit => 80

      t.timestamps
    end
  end
end
