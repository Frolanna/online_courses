class CreateCoursesCompetencesJoinTables < ActiveRecord::Migration[7.1]
  def change
    create_table :course_competences, id: false do |t|
      t.references :course
      t.references :competence
      t.timestamps
    end

    add_index :course_competences, [:course_id, :competence_id], unique: true
  end
end
