class Lesson < ApplicationRecord
    validates :topic, presence: true
    validates :field, presence: true
    validates :description, presence: true
    belongs_to :user
    has_many :messages
    def user_email
        user.email
    end

      has_many :joinable, dependent: :destroy
      has_many :joins, through: :joinable, source: :user

   
  
    after_create_commit :broadcast_new_lesson
    after_update_commit :broadcast_updated_lesson
      
      
    after_destroy_commit do
      broadcast_destroy_lesson
    end
    
    def broadcast_new_lesson
      current_user = user
        broadcast_prepend_later_to 'public_lessons',
                                    target: 'public_lessons',
                                    partial: 'lessons/lesson',
                                    locals: { lesson: self, join_status: false,current_user: current_user }
        broadcast_prepend_later_to 'private_lessons',
                                    target: 'private_lessons',
                                    partial: 'lessons/lesson',
                                    locals: { lesson: self, join_status: false,current_user: current_user }
      end
    
      def broadcast_updated_lesson
        current_user = user
        shared_target_lesson = "lesson_#{id}"
        private_target_channel = "#{@user_gid} private_joins"
        broadcast_replace_later_to 'public_lessons',
                                    target: shared_target_lesson,
                                    partial: 'lessons/lesson',
                                    locals: { lesson: self,join_status: false, current_user: current_user }
        broadcast_replace_later_to "private_lessons",
                                    target: shared_target_lesson,
                                    partial: 'lessons/lesson',
                                    locals: { lesson: self, join_status: false, current_user: current_user }
      end

    
      def broadcast_destroy_lesson
        
        broadcast_remove_to 'public_lessons',
                            target: "lesson_#{id}"
        broadcast_remove_to 'private_lessons',
                            target: "lesson_#{id}"
      end
    
end
