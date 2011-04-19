class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.datetime :datetime
      t.integer :event_id

      t.timestamps
    end
    Event.all.each do |event|
      event.build_slot(:datetime => event.slot.date_time)
      event.save!
    end
  end

  def self.down
    drop_table :slots
  end
end
