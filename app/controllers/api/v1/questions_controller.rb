class Api::V1::QuestionsController < ApplicationController
  before_action :load_question, only: [:show]

  def show
    render json: @question, locale: params[:locale]
  end

  private

  def load_question
    @question = Question.find_by(uuid: params[:uuid])
    return if @question

    render json: { error: 'Question not found' }, status: :not_found
  end
end
