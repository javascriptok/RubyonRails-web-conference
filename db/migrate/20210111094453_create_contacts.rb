class CreateContacts < ActiveRecord::Migration[5.2]
    def change
        create_table :contacts do |t|
            t.belongs_to :user, index: true
            t.string :first_name
            t.string :last_name
            t.string :company
            t.string :department
            t.string :email
            t.string :phone1
            t.string :phone2
            t.text :notes
            t.string :custom_field1
            t.string :custom_field2

            t.timestamps
        end
    end
end
