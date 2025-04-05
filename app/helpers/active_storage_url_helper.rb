module ActiveStorageUrlHelper
    def variant_url(record)
      return nil unless record
      
      if Rails.application.config.active_storage.service == :cloudflare
        cloudflare_url(record)
      else
        standard_url(record)
      end
    end
    
    private
    
    def cloudflare_url(record)
      endpoint = ENV["CLOUDFLARE_R2_ENDPOINT"]
      return nil unless endpoint
      endpoint = endpoint.chomp('/') # Remove trailing slash if present
      
      key = storage_key(record)
      return nil unless key
      
      "#{endpoint}/#{key}"
    end
    
    def standard_url(record)
      host = Rails.application.routes.default_url_options[:host]
      return nil unless host
      
      rails_representation_url(record, host: host) rescue nil
    end
    
    def storage_key(record)
      # Direct key access is fastest
      return record.key if record.respond_to?(:key)
      
      # For variants - make sure processed blob exists
      if record.respond_to?(:processed) && record.processed.present?
        return record.processed.key if record.processed.respond_to?(:key)
      end
      
      # For attachments
      if record.respond_to?(:blob) && record.blob
        return record.blob.key
      end
      
      nil
    end
  end