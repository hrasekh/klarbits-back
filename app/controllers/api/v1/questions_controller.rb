class Api::V1::QuestionsController < ApplicationController
  before_action :load_question, only: %i[show update destroy]

  def show
    render json: @question, locale: params[:locale]
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    head :no_content
  end

  private

  def load_question
    @question = Question.find_by(uuid: params[:uuid])
    return if @question

    render json: { error: 'Question not found' }, status: :not_found
  end
end
