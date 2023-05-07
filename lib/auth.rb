require 'jwt'

class Auth
  ALGORITHM = 'HS256'

  def self.issue(payload, exp: 7.days.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(
      payload,
      auth_secret,
      ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token,
      auth_secret,
      true,
      { algorithm: ALGORITHM }).first
  end

  def self.auth_secret
    ENV["AUTH_SECRET"]
  end
end
