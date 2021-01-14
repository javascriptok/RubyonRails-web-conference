class AddColumnsToUsers < ActiveRecord::Migration[5.2]
    def change
        add_column :users, :first_name, :string
        add_column :users, :last_name, :string
        add_column :users, :phone, :string
        add_column :users, :city, :string
        add_column :users, :state, :string
        add_column :users, :postal_code, :string
        add_column :users, :country, :string
        add_column :users, :bio, :text
    end
end
