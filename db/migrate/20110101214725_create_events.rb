class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :month
      t.integer :day
      t.string :hour
      t.string :title
    end
  end

  def self.down
    drop_table :events
  end
end

