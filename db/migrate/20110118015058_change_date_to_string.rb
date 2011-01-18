class ChangeDateToString < ActiveRecord::Migration
  def self.up
    remove_column :events, :date
    add_column :events, :date, :string
  end

  def self.down
    remove_column :events, :date
    add_column :events, :date, :integer
  end
end
