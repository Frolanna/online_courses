class AuthorsController < ApplicationController
  def index
    authors = Author.all

    render json: { authors: },
           include: { courses: { only: [:id, :name] } },
           status: :ok
  end

  def show
    author = Author.find(params[:id])

    render json: { author: },
           include: { courses: { only: [:id, :name] } },
           status: :ok
  end

  def create
    author = Author.new(author_params)

    if author.save
      render json: { author: }, status: :ok
    else
      render json: {
        errors: author.errors.full_messages
      }, status: :bad_request
    end

  end

  def update
    author = Author.find(params[:id])

    if author.update(author_params)
      render json: { author: }, status: :ok
    else
      render json: {
        errors: author.errors.full_messages
      }, status: :bad_request
    end
  end

  def destroy
    author = Author.find(params[:id])

    begin
      ActiveRecord::Base.transaction do
        ReassignAuthorCourses.call(author:)
        author.destroy!
      end
    rescue ReassignAuthorCourses::NewAuthorNotFound => e
      render json: {
        errors: e.message
      }, status: :forbidden
    rescue ActiveRecord::RecordNotDestroyed
      render json: {
        errors: 'Failed to destroy author'
      }, status: :forbidden
    end
  end

  private

  def author_params
    @author_params ||= params.require(:author).permit(:name)
  end
end