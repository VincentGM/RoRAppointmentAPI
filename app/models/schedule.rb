class Schedule < ApplicationRecord
    has_many :appointments

    validates_presence_of :name
end
