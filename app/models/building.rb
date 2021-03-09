class Building < ApplicationRecord
    has_many :apartments

    validates :name, presence: true

    def to_s
        self.name
    end
end
