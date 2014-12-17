class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :listing
      
      t.string :content_type
      t.string :content_link
      t.string :caption
      t.integer :content_group

      t.timestamps
    end
  end
end
