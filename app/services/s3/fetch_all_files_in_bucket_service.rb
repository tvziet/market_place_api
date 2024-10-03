# app/services/s3/fetch_all_files_in_bucket_service.rb

module S3
  class FetchAllFilesInBucketService < BaseService
    # List all files in a bucket, if in the bucket has more than 1_000 files, we need to paginate to improve performance
    #
    # @param bucket [String] The name of the S3 bucket.
    # @raise [Aws::Errors::ServiceError] If an AWS-related error occurs
    def call(bucket:, limit: 1_000)
      # TODO: Add error handling
      initial_response = client.list_objects_v2(bucket:, max_keys: limit)
      files = initial_response.contents.map(&:key)
      next_continuation_token = initial_response.next_continuation_token

      while next_continuation_token.present?
        response = client.list_objects_v2(bucket:, max_keys: limit, continuation_token: next_continuation_token)
        files += response.contents.map(&:key)
        next_continuation_token = response.next_continuation_token
      end

      files
    end
  end
end
