# app/serializers/api/v1/simplified_question_serializer.rb
class Api::V1::SimplifiedQuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :question, :image_url

  def image_url
    return unless object.image.attached?

    rails_blob_url(object.image)
  end
end
