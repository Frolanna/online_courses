class Course < ApplicationRecord
  belongs_to :author
  has_many :course_competences
  has_many :competences, through: :course_competences

  validates :name, presence: true
end
