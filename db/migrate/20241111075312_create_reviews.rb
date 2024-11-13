class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.float "rating", null: false
      t.string "title", null: false
      t.text "content", null: false

      t.timestamps
    end
  end
end
