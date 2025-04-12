class Api::V1::AnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer, :is_correct, :translation

  def initialize(object, locale: 'en')
    super(object)
    @locale = locale
  end

  def translation
    object.translated_answer(@locale)
  end
end
