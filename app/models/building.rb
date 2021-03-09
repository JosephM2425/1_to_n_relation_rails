class Building < ApplicationRecord
    has_many :apartments

    validates :name, presence: true
end
