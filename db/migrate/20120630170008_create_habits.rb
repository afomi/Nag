class CreateHabits < ActiveRecord::Migration
  def self.up
    create_table :habits do |t|
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :habits
  end
end
