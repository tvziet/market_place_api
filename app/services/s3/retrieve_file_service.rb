# app/services/aws_s3/retrieve_file_service.rb

module S3
  class RetrieveFileService < BaseService
    # Retrieves a file from the S3 bucket specified by the bucket parameter.
    # key is the object key for the retrieved file.
    #
    # @param bucket [String] The name of the S3 bucket.
    # @param key [String] The key (path) of the file to retrieve.
    # @return [Aws::S3::Types::GetObjectOutput]
    # @raise [Aws::Errors::ServiceError] If an AWS-related error occurs
    def call(bucket:, key:)
      client.get_object(bucket:, key:)
      # TODO: Add error handling
    end
  end
end
