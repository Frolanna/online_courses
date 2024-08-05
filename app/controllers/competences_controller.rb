class CompetencesController < ApplicationController
  def index
    competences = Competence.all

    render json: { competences: },
           include: { courses: { only: [:id, :name] } },
           status: :ok
  end

  def show
    competences = Competence.find(params[:id])

    render json: { competences: },
           include: { courses: { only: [:id, :name] } },
           status: :ok
  end

  def create
    competence = Competence.new(competence_params)

    if params[:course_ids]
      competence.courses << Course.find(params[:course_ids])
    end

    if competence.save
      render json: { competence: },
             include: { courses: { only: [:id, :name] } },
             status: :ok
    else
      render json: {
        errors: competence.errors.full_messages
      }, status: :bad_request
    end
  end

  def update
    competence = Competence.find(params[:id])

    if params[:course_ids]
      competence.courses = Course.find(params[:course_ids])
    end

    if competence.update(competence_params)
      render json: { competence: },
             include: { courses: { only: [:id, :name] } },
             status: :ok
    else
      render json: {
        errors: course.errors.full_messages
      }, status: :bad_request
    end
  end

  def destroy
    competence = Competence.find(params[:id])

    begin
      competence.destroy!
    rescue ActiveRecord::RecordNotDestroyed
      render json: {
        errors: 'Failed to destroy course'
      }, status: :forbidden
    end
  end

  private

  def competence_params
    @competence_params ||= params.require(:competence).permit(:name, course_ids: [])
  end
end