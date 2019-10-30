class JsonWebToken
  def self.encode(payload, expire_time = nil)
    payload[:expire] = expire_time || self.expire
    JWT.encode(payload, self.secret)
  end

  def self.decode(token)
    data = JWT.decode(token, self.secret).first
    data = HashWithIndifferentAccess.new(data)
    data if data[:expire].to_time.utc > Time.now.utc
  end

  def self.secret
    ENV['SECRET'] || 'secret'
  end

  def self.expire
    72.hours.from_now.utc
  end
end