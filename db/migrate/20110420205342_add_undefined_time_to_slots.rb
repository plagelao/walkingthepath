class AddUndefinedTimeToSlots < ActiveRecord::Migration
  def self.up
    add_column :slots, :undefined_time, :boolean
  end

  def self.down
    remove_column :slots, :undefined_time
  end
end
