# config/initializers/active_storage.rb

Rails.application.config.after_initialize do
    # Check if the :cloudflare service configuration exists
    # Adjust 'cloudflare' if your service name in storage.yml is different
    if Rails.application.config.active_storage.service_configurations&.key?('cloudflare')
        # Get the existing configuration for the service
        service_config = Rails.application.config.active_storage.service_configurations['cloudflare']

        # Merge additional client options for the aws-sdk-s3 gem
        # Use deep_merge! to safely merge nested hashes like :client
        service_config.deep_merge!(
        client: {
            # Disable SDK-computed checksums (CRC32, SHA1, etc.)
            # This often resolves the "You can only specify one checksum at a time"
            # error with S3-compatible storage like Cloudflare R2.
            compute_checksums: false
        }
        )
    end
  
    # Add similar blocks here if you have other S3-compatible services
    # defined in storage.yml that might encounter the same issue.
    # Example for a service named 'minio':
    # if Rails.application.config.active_storage.service_configurations&.key?('minio')
    #   Rails.application.config.active_storage.service_configurations['minio'].deep_merge!(
    #     client: { compute_checksums: false }
    #   )
    # end
end