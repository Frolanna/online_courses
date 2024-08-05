class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.references :author, null: false, foreign_key: true
      t.timestamps
    end
  end
end
