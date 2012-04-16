class AddStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.string :app
      t.string :key
      t.text :value
      t.timestamps
    end
  end

  def self.down
    drop_table :stats
  end
end
