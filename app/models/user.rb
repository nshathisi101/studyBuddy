class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :lessons
         has_many :messages

         has_many :joinable, dependent: :destroy
         has_many :joined_lessons, through: :joinable, source: :lesson

         has_many :bmesseage, dependent: :destroy
         has_many :comment_lessons, through: :bmesseage, source: :lesson

  def joined?(lesson)
    joined_lessons.include?(lesson)
  end

  def join(lesson)
    if joined_lessons.include?(lesson)
      joined_lessons.destroy(lesson)
    else
      joined_lessons << lesson
    end
    public_target = "lesson_#{lesson.id}_public_joins"
    broadcast_replace_later_to 'public_joins',
                              target: public_target,
                              partial: 'joins/join_count',
                              locals: { lesson: lesson }
  end
end
