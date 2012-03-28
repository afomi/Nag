class CreateTouchpoints < ActiveRecord::Migration
  def self.up
    create_table :touchpoints do |t|
      t.string :key
      t.text :value
      t.integer :points
      t.string :description
      t.integer :checkin_id
      t.timestamps
    end
  end

  def self.down
    drop_table :touchpoints
  end
end
