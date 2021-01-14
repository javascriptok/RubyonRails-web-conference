class Schedule < ApplicationRecord
    belongs_to :user

    has_many :guest_permissions
end
