# app/services/s3/generate_presigned_url_service.rb

module S3
  class GeneratePresignedUrlService < BaseService
    # Generates a presigned URL for an S3 object
    #
    # @param bucket [String] The name of the S3 bucket
    # @param key [String] The key (path) of the object within the bucket
    # @param expires_in [Integer, #to_i] The number of seconds until the presigned URL expires
    #
    # @return [String] The presigned URL for the S3 object
    #
    # @raise [Aws::Errors::ServiceError] If an AWS-related error occurs
    def call(bucket:, key:, expires_in:)
      signer = Aws::S3::Presigner.new(client:)
      signer.presigned_url(:get_object, bucket:, key:,
                                        expires_in: expires_in.to_i)
      # TODO: Add error handling
    end
  end
end
