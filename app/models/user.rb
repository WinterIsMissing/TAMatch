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
    "https://350764f781ef4b3a8bb9e2746e9cf8b1.vfs.cloud9.ap-southeast-1.amazonaws.com/auth?#{self.login_token}"
  end

  def login_token_expired?
    
    (self.token_generated_at + token_validity.to_s) > Time.now.utc.to_s
  end

  def expire_token!
    self.login_token = nil
    #self.token_generated_at = Time.now.utc - token_validity.to_s
    save!
  end

  private

  def generate_token
    SecureRandom.hex(20)
  end

  def token_validity
    1.hour
  end
end
