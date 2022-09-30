class AddUserToBmesseages < ActiveRecord::Migration[7.0]
  def change
    add_reference :bmesseages, :user, null: false, foreign_key: true
    add_reference :bmesseages, :lessons, null: false, foreign_key: true
  end
end
