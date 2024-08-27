module ResponseHandler
  extend ActiveSupport::Concern

  def success_response(data, options = {})
    serializer = determine_serializer(data, options[:serializer])
    pagination = options[:pagination]

    serialized_data = serialized_data(data, serializer, pagination)
    status = options[:status] || :ok
    render json: serialized_data, status: status if serialized_data.is_a?(Hash)
  end

  def errors_response(errors, options = {})
    status = options[:status] || :unprocessable_entity
    render json: errors, status:
  end

  private

  def determine_serializer(data, serializer)
    return serializer if serializer.present?
    return "#{data.klass}Serializer".constantize if data.is_a?(ActiveRecord::Relation)
    return "#{data.class}Serializer".constantize if data.is_a?(ActiveRecord::Base)

    nil
  end

  def serialized_data(data, serializer, pagination)
    if serializer.present? && pagination.present?
      serializer.new(data, pagination).serializable_hash
    elsif serializer.present?
      serializer.new(data).serializable_hash
    else
      data
    end
  end
end
