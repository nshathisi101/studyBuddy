class Lesson < ApplicationRecord
    validates :topic, presence: true
    validates :field, presence: true
    validates :description, presence: true
    belongs_to :user
    def user_email
        user.email
      end
end
