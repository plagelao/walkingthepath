class AddTimestampsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :created_at, :timestamp
    add_column :events, :updated_at, :timestamp
  end

  def self.down
    remove_column :events, :updated_at
    remove_column :events, :created_at
  end
end
