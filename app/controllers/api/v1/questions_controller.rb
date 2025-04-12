class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[update]
  before_action :admin_required, only: %i[update]
  before_action :load_question, only: %i[show update]

  def show
    render json: {
      question: Api::V1::QuestionSerializer.new(@question).as_json,
      meta: Api::V1::QuestionMetaSerializer.new(@question).as_json
    }
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  private

  def load_question
    @question = Question.find_by(uuid: params[:uuid])
    return if @question

    render json: { error: 'Question not found' }, status: :not_found
  end

  def admin_required
    return if current_user&.admin?

    render json: { error: 'Unauthorized' }, status: :forbidden
  end

  def question_params
    params.require(:question).permit(:image)
  end
end
