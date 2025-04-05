require_relative '../../../helpers/active_storage_url_helper'

class Api::V1::QuestionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActiveStorageUrlHelper

  attributes :uuid, :title, :question, :translation, :next_question, :previous_question, :answers,
             :statistic, :image

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

  def image
    {
      original: image_url,
      large: large_url,
      medium: medium_url,
      thumbnail: thumbnail_url
    }
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

  def image_url
    variant_url(object.image) if object.image.attached?
  end

  def thumbnail_url
    variant_url(object.image.variant(resize_to_limit: [100, 100])) if object.image.attached?
  end

  def medium_url
    variant_url(object.image.variant(resize_to_limit: [500, 500])) if object.image.attached?
  end

  def large_url
    variant_url(object.image.variant(resize_to_limit: [900, 900])) if object.image.attached?
  end

end
