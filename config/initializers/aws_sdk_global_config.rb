# GNU nano 6.2                                                config/initializers/aws_sdk_global_config.rb                                                          
# config/initializers/aws_sdk_global_config.rb
require 'aws-sdk-s3'

puts "[AWS SDK DEBUG] Forcing global S3 config: compute_checksums: false"

Aws.config.update({
  s3: {
    compute_checksums: false
  }
})

# Optional: Verify the config was set
# puts "[AWS SDK DEBUG] Current Aws.config[:s3]: #{Aws.config[:s3].inspect}"
