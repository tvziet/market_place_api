class JsonWebToken
  def self.encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV.fetch('SECRET_KEY'), 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, ENV.fetch('SECRET_KEY'), true, { algorithm: 'HS256' })
    payload = decoded[0]
    ActiveSupport::HashWithIndifferentAccess.new(payload)
  end
end
