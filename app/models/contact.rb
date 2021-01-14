class Contact < ApplicationRecord
    belongs_to :user

    validates :email, length: { maximum: 256 }, format: { with: /\A[\w+\-\'.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone1, allow_blank: true, length: { maximum: 15, minimum: 10 }, format: { with: /[\.\-\(\) \;\+]/, message: "is invalid."}
    validates :phone2, allow_blank: true, length: { maximum: 15, minimum: 10 }, format: { with: /[\.\-\(\) \;\+]/, message: "is invalid."}
end