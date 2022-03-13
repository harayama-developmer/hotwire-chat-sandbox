class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.text :description
      t.integer :messages_count, null: false, default: 0

      t.timestamps
    end
  end
end
