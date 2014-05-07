class CreateThoughts < ActiveRecord::Migration
  def change
    create_table :thoughts do |t|
      t.text :text
      t.integer :position

      t.timestamps
    end
  end
end
