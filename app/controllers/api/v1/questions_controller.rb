class Api::V1::QuestionsController < ApplicationController
  before_action :load_question, only: [:show]

  def show
    render json: @question
  end

  private

  def load_question
    @question = Question.find_by(params[:uuid])
    return if @question

    render json: { error: 'Question not found' }, status: :not_found
  end

  def question_params
    params.require(:question).permit(:content, :category_id, :subcategory_id)
  end
end
