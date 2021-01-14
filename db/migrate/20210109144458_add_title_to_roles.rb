class AddTitleToRoles < ActiveRecord::Migration[5.2]
    def change
        add_column :roles, :title, :string
    end
end
