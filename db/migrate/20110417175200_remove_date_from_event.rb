class RemoveDateFromEvent < ActiveRecord::Migration
  def self.up
    remove_column :events, :date
  end

  def self.down
    add_column :events, :date, :integer
  end
end
