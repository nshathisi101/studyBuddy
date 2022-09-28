class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :topic
      t.string :field
      t.text :description

      t.timestamps
    end
  end
end
