require_relative '../../../helpers/active_storage_url_helper'

class Api::V1::QuestionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActiveStorageUrlHelper

  attributes :uuid, :title, :question, :translation, :answers, :image

  def answers
    object.answers.map do |answer|
      Api::V1::AnswerSerializer.new(answer).as_json
    end
  end

  def translation
    object.translated_question(Current.locale)
  end

  def image
    return unless object.image.attached?

    Api::V1::ImageSerializer.new(object.image).as_json if object.image.attached?
  end
end
