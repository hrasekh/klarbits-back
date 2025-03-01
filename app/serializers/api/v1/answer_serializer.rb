class Api::V1::AnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer, :is_correct
end
