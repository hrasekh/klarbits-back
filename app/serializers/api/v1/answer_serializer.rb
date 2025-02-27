class Api::V1::AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :is_correct
end
