class Lesson < ApplicationRecord
    validates :topic, presence: true
    validates :field, presence: true
    validates :description, presence: true
end
