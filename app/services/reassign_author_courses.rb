class ReassignAuthorCourses < ApplicationService
  attr_reader :author

  class NewAuthorNotFound < StandardError
    def message
      "New author for courses not found"
    end
  end

  def initialize(author:)
    @author = author
  end

  def call
    new_author = Author
                   .where.not(id: author.id)
                   .order(Arel.sql('random()'))
                   .first

    courses = author.courses
    raise NewAuthorNotFound if new_author.nil? && courses.present?

    if courses.present?
      courses.update_all(author_id: new_author.id)
    end
  end
end