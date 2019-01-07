class User < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def self.find_user_by(value)
    where(["username = :value OR email = :value", {value: value}]).first
  end

  def send_login_link(user)
    generate_login_token


    template = login_link
    # user is the actual email, it is not an object
    ApplicationMailer.login_email(user,template).deliver_now
  end

  def generate_login_token
    self.login_token = generate_token
    self.token_generated_at = Time.now.utc
    save!
  end

  def login_link
    "http://localhost:8080/auth?#{self.login_token}"
  end

  def login_token_expired?
    (self.token_generated_at + token_validity.to_s) > Time.now.utc.to_s
  end

  def expire_token!
    self.login_token = nil
    save!
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64(20)
  end

  def token_validity
    24.hour
  end
  
end
class << self
  def from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.save!
    user
  end
end
