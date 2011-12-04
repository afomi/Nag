class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :project_id
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
