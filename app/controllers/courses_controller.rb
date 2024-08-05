class CoursesController < ApplicationController
  def index
    courses = Course.all

    render json: { courses: },
           include: {
             author: { only: [:id, :name] },
             competences: { only: [:id, :name] },
           },
           status: :ok
  end

  def show
    course = Course.find(params[:id])

    render json: { course: },
           include: {
             author: { only: [:id, :name] } ,
             competences: { only: [:id, :name] },
           },
           status: :ok
  end

  def create
    course = Course.new(course_params)

    if params[:competence_ids]
      course.competences << Competence.find(params[:competence_ids])
    end

    if course.save
      render json: { course: },
             include: {
               author: { only: [:id, :name] },
               competences: { only: [:id, :name] },
             },
             status: :ok
    else
      render json: {
        errors: course.errors.full_messages
      }, status: :bad_request
    end
  end

  def update
    course = Course.find(params[:id])

    if params[:competence_ids]
      course.competences = Competence.find(params[:competence_ids])
    end

    if course.update(course_params)
      render json: { course: },
             include: {
               author: { only: [:id, :name] },
               competences: { only: [:id, :name] },
             },
             status: :ok
    else
      render json: {
        errors: course.errors.full_messages
      }, status: :bad_request
    end
  end

  def destroy
    course = Course.find(params[:id])

    begin
      course.destroy!
    rescue ActiveRecord::RecordNotDestroyed
      render json: {
        errors: 'Failed to destroy course'
      }, status: :forbidden
    end
  end

  private

  def course_params
    @course_params ||= params.require(:course).permit(:name, :author_id, :competence_ids)
  end
end