class Api::V1::AnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer, :is_correct, :translation

  def translation
    object.translated_answer(Current.locale)
  end
end
