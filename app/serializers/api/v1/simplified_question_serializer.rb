# app/serializers/api/v1/simplified_question_serializer.rb
class Api::V1::SimplifiedQuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :content
end
