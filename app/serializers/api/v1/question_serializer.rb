class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :question, :translation, :next_question, :previous_question, :answers,
             :statistic

  def next_question
    serialize_question(next_question_object)
  end

  def previous_question
    serialize_question(previous_question_object)
  end

  def answers
    object.answers.map do |answer|
      Api::V1::AnswerSerializer.new(answer).as_json
    end
  end

  def statistic
    {
      total: object.category.questions.count,
      current: object.category.questions.index(object) + 1
    }
  end

  def translation
    object.translated_question(Current.locale)
  end

  private

  def next_question_object
    object.category.questions.where('id > ?', object.id).order(id: :asc).first
  end

  def previous_question_object
    object.category.questions.where(id: ...object.id).order(id: :desc).first
  end

  def serialize_question(question)
    Api::V1::SimplifiedQuestionSerializer.new(question).as_json if question
  end
end
