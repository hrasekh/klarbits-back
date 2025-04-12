# app/serializers/api/v1/question_meta_serializer.rb
class Api::V1::QuestionMetaSerializer < ActiveModel::Serializer
  attributes :statistic, :next_question, :previous_question

  def initialize(question, condition: nil)
    super(question)
    @question = question
    @condition = condition
  end

  def statistic
    {
      total: relevant_questions.count,
      current: current_position_in_relevant_scope
    }
  end

  def next_question
    serialize_question(next_relevant_question_object)
  end

  def previous_question
    serialize_question(previous_relevant_question_object)
  end

  private

  def relevant_questions
    @relevant_questions ||= begin
      scope = Question.base
      scope = scope.or(Question.with_condition(@condition)) if @condition.present?
      scope.order(:id)
    end
  end

  def current_position_in_relevant_scope
    relevant_questions.where(id: ..@question.id).count
  end

  def next_relevant_question_object
    relevant_questions.where('id > ?', @question.id).first
  end

  def previous_relevant_question_object
    relevant_questions.where(id: ...@question.id).last
  end

  def serialize_question(question)
    question&.then { |q| Api::V1::SimplifiedQuestionSerializer.new(q).as_json }
  end
end
