class CreateSchedules < ActiveRecord::Migration[5.2]
    def change
        create_table :schedules do |t|
            t.belongs_to :user, index: true
            t.string :title, :null => false
            t.date :start_date
            t.date :end_date
            t.time :start_time
            t.time :end_time
            t.boolean :all_day, :default => false
            t.boolean :repeat_weekly, :default => false
            t.integer :repeat_day
            t.boolean :mute_video, :default => false
            t.boolean :mute_audio, :default => false
            t.boolean :record_meeting, :default => false
            t.text :description
            t.string :events_tag
            t.string :notification_type
            t.integer :notification_minutes

            t.timestamps
        end
    end
end
