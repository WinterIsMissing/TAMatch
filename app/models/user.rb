require 'time'

class User < ApplicationRecord
  validates_presence_of :username, :email, :auth_level
  validates_uniqueness_of :username, :email
  has_one :instructor_preference

  def send_login_link(user)
    generate_login_token

    template = login_link
    # user is the actual email, it is not an object
    ApplicationMailer.login_email(user.email,template).deliver_now
    rescue
    ApplicationMailer.login_email(user,template).deliver_now
  end

  def generate_login_token
    self.login_token = generate_token
    self.token_generated_at = Time.now
    save!
    return self.login_token
  end

  def login_link

    "https://young-lowlands-69353.herokuapp.com/auth?#{self.login_token}"

  end

  def login_token_expired?
    (Time.parse(self.token_generated_at) + token_validity) < Time.now
  end

  def expire_token!
    #self.login_token = nil
    self.token_generated_at = Time.now - token_validity
    save!
  end
  
  private

  def generate_token
    SecureRandom.urlsafe_base64(20)
  end
  def token_validity
     24.hour
  end

  
  #STATIC

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(email: auth_hash['info']['email'])
    user.uid ||= auth_hash['uid']
    user.provider ||= auth_hash['provider']
    user.fullname ||= auth_hash['info']['name']
    user.username ||= auth_hash['info']['email']
    #user.location = auth_hash['info']['location']
    user.image_url ||= auth_hash['info']['image']
    user.url ||= auth_hash['info']['urls']
    user.auth_level ||= 'student'
    user.save!
    return user
  end
end 

