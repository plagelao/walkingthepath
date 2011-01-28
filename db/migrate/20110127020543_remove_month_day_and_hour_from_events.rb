class RemoveMonthDayAndHourFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :month
    remove_column :events, :day
    remove_column :events, :hour
  end

  def self.down
    add_column :events, :hour, :string
    add_column :events, :day, :integer
    add_column :events, :month, :string
  end
end
