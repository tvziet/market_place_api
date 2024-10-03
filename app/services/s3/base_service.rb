# app/services/aws_s3/base_service.rb

module S3
  class BaseService
    private

    def client
      @client ||= Aws::S3::Client.new(
        access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
        region: ENV.fetch('AWS_REGION')
      )
    end
  end
end
