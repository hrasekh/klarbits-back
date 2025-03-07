class Api::V1::HomeController < ApplicationController
  before_action :load_question, only: [:index]

  def index
    render json: {
      citizenship_test: @question
    }
  end

  private

  def load_question
    @question = Question.first
    return if @question

    render json: { error: 'Question not found' }, status: :not_found
  end
end
