class AddLinkToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :link, :string
  end

  def self.down
    remove_column :events, :link
  end
end
