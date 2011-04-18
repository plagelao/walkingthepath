class RemoveDateFromEvent < ActiveRecord::Migration
  def self.up
    Event.all.each do |event|
      event.update_attributes(:datetime => event.date_time)
      event.save
    end
    remove_column :events, :date
  end

  def self.down
    Event.all.each do |event|
      date_as_string = event.year + event.month + event.day + event.hour + event.minute
      event.update_attributes(:date => date_as_string.to_i)
      event.save
    end
    add_column :events, :date, :integer
  end
end
