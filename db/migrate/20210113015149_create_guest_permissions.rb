class CreateGuestPermissions < ActiveRecord::Migration[5.2]
    def change
        create_table :guest_permissions do |t|
            t.belongs_to :schedule, index: true
            t.string :name
            t.boolean :value

            t.timestamps
        end
    end
end
