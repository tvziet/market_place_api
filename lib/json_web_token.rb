class JsonWebToken
  def self.encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['SECRET_KEY'])
  end

  def self.decode(token)
    decoded = JWT.decode(token, ENV['SECRET_KEY']).first
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  end
end
