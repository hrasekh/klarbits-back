require_relative '../../../helpers/active_storage_url_helper'

class Api::V1::ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActiveStorageUrlHelper

  attributes :original, :large, :medium, :thumbnail

  def original
    variant_url(object) if object.attached?
  end

  def thumbnail
    variant_url(object.variant(resize_to_limit: [100, 100])) if object.attached?
  end

  def medium
    variant_url(object.variant(resize_to_limit: [500, 500])) if object.attached?
  end

  def large
    variant_url(object.variant(resize_to_limit: [900, 900])) if object.attached?
  end
end
