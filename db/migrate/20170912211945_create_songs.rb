class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :length
      t.string :artist

      t.timestamps
    end
  end
end
