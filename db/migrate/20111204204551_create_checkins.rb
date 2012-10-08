class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.integer :project_id
      t.integer :touchpoint_id
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
