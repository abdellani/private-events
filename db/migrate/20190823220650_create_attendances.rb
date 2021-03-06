# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.integer :attendee_id
      t.integer :event_id

      t.timestamps
    end
  end
end
