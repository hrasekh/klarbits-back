# app/serializers/api/v1/question_meta_serializer.rb
class Api::V1::QuestionMetaSerializer < ActiveModel::Serializer
  attributes :statistic, :next_question, :previous_question, :locale

  def initialize(question)
    super
    @question = question
  end

  def statistic
    {
      total: @question.category.questions.count,
      current: current_position
    }
  end

  def next_question
    serialize_question(next_question_object)
  end

  def previous_question
    serialize_question(previous_question_object)
  end

  delegate :locale, to: :Current

  private

  def current_position
    @question.category.questions.where(id: ..@question.id).count
  end

  def next_question_object
    @question.category.questions.where('id > ?', @question.id).order(id: :asc).first
  end

  def previous_question_object
    @question.category.questions.where(id: ...@question.id).order(id: :desc).first
  end

  def serialize_question(question)
    question ? Api::V1::SimplifiedQuestionSerializer.new(question).as_json : nil
  end
end
