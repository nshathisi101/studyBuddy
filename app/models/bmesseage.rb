class Bmesseage < ApplicationRecord
    belongs_to :user
    belongs_to :lesson

    has_many :messages
    def user_email
        user.email
    end

    after_create_commit :broadcast_new_lesson

    def broadcast_new_lesson
          broadcast_prepend_later_to 'messageing',
                                      target: 'messageing',
                                      partial: 'bmesseages/messages',
                                      locals: { bmesseage: self}
        end

end
