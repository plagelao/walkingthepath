class AddDatetimeToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :datetime, :datetime
  end

  def self.down
    remove_column :events, :datetime
  end
end
