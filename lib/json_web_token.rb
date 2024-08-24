class JsonWebToken
  def self.encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV.fetch('SECRET_KEY'))
  end

  def self.decode(token)
    decoded = JWT.decode(token, ENV.fetch('SECRET_KEY')).first
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  end
end
