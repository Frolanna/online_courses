# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

authors = [
  {id: 1, name: "Федоров Тимофей"},
  {id: 2, name: "Комаров Лев"},
  {id: 3, name: "Кузнецов Александр"},
  {id: 4, name: "Гусева Юлия"},
]

courses = [
  {id: 1, name: "Английский", author_id: 1},
  {id: 2, name: "Математика", author_id: 2},
  {id: 3, name: "Русский язык", author_id: 1},
  {id: 4, name: "Программирование", author_id: 3},
]

competences = [
  {id: 1, name: "Чтение"},
  {id: 2, name: "Устная речь"},
  {id: 3, name: "Письмо"},
  {id: 4, name: "Счет"},
  {id: 5, name: "Логическое мышление"},
  {id: 6, name: "Критическое мышление"},
]

course_competences = [
  {competence_id: 1, course_id: 1},
  {competence_id: 1, course_id: 3},
  {competence_id: 2, course_id: 1},
  {competence_id: 2, course_id: 3},
  {competence_id: 3, course_id: 1},
  {competence_id: 3, course_id: 3},
  {competence_id: 4, course_id: 2},
  {competence_id: 5, course_id: 2},
  {competence_id: 5, course_id: 4},
  {competence_id: 6, course_id: 2},
  {competence_id: 6, course_id: 4},
]

Author.upsert_all(authors)
Course.upsert_all(courses)
Competence.upsert_all(competences)
CourseCompetence.upsert_all(course_competences, unique_by: [:competence_id, :course_id])

['authors', 'courses', 'competences', 'course_competences'].each do |table_name|
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end
