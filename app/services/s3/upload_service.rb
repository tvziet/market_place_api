# app/services/aws_s3/upload_file_service.rb

module S3
  class UploadService < BaseService
    # Uploads a file to the S3 bucket specified by the bucket parameter.
    # key is the object key for the uploaded file.
    # body is the file content.
    #
    # @param bucket [String] The name of the S3 bucket.
    # @param key [String] The key (path) under which the file will be stored in the bucket.
    # @param body [String] The file content.
    # @return [Aws::S3::Types::PutObjectOutput] The response from the S3 put_object operation
    # @raise [Aws::Errors::ServiceError] If an AWS-related error occurs
    def call(bucket:, key:, body:)
      client.put_object(bucket:, key:, body:)
      # TODO: Add error handling
    end
  end
end
