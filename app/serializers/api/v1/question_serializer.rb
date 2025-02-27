class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :content, :next_question, :previous_question

  def next_question
    next_question_obj = object.category.questions.where('id > ?', object.id).order(id: :asc).first
    Api::V1::SimplifiedQuestionSerializer.new(next_question_obj).as_json if next_question_obj
  end

  def previous_question
    previous_question_obj = object.category.questions.where(id: ...object.id).order(id: :desc).first
    Api::V1::SimplifiedQuestionSerializer.new(previous_question_obj).as_json if previous_question_obj
  end
end
