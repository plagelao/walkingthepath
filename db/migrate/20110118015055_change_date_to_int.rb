class ChangeDateToInt < ActiveRecord::Migration
  def self.up
    remove_column :events, :date
    add_column :events, :date, :integer
  end

  def self.down
    remove_column :events, :date
    add_column :events, :date, :string
  end
end
