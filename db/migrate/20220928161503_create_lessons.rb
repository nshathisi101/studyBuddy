class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.integer :lesson_id, auto_increment: true
      t.string :topic
      t.string :field
      t.text :description

      t.timestamps
    end
  end
end
