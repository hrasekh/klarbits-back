module ActiveStorageUrlHelper
    def variant_url(record)
      return nil unless record
      
      if Rails.application.config.active_storage.service == :cloudflare
        generate_cloudflare_url(record)
      else
        generate_standard_url(record)
      end
    end
    
    private
    
    def generate_cloudflare_url(record)
      endpoint = ENV["CLOUDFLARE_R2_ENDPOINT_PUBLIC"]&.chomp('/')
      return nil unless endpoint
      
      key = extract_storage_key(record)
      return nil unless key
      
      "#{endpoint}/#{key}"
    end
    
    def generate_standard_url(record)
      host = Rails.application.routes.default_url_options[:host]
      return nil unless host
      
      begin
        rails_representation_url(record, host: host)
      rescue => e
        Rails.logger.error("URL generation error: #{e.message} for #{record.class}")
        nil
      end
    end
    
    def extract_storage_key(record)
      case
      when record.respond_to?(:processed)
        extract_variant_key(record)
      when record.respond_to?(:key)
        record.key
      when record.respond_to?(:blob) && record.blob&.respond_to?(:key)
        record.blob.key
      else
        Rails.logger.warn("Cannot extract key from #{record.class}")
        nil
      end
    end
    
    def extract_variant_key(variant)
      begin
        processed = variant.processed
        processed.key if processed.respond_to?(:key)
      rescue => e
        Rails.logger.error("Variant processing error: #{e.message}")
        nil
      end
    end
end