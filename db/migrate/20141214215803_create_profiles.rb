class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :agent
      t.text :bio
      t.string :website
      t.string :facebook
      t.string :license
      t.string :designations

      t.timestamps
    end
  end
end
