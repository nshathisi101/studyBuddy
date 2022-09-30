class CreateBmesseages < ActiveRecord::Migration[7.0]
  def change
    create_table :bmesseages do |t|
      t.text :body

      t.timestamps
    end
  end
end
