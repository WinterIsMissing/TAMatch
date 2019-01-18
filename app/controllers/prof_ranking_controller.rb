class ProfRankingController < ApplicationController
  def index
    @applicants = Applicant.all
    ip = User.find_by(login_token: session[:user_token]).instructor_preference
    preferences = ip.nil? ? {} : ip.preferences
    preferences ||= {}
    # puts preferences
    @preferences = preferences
  end
  def update
    # puts params
    rating = params[:preference][:rating]
    email = params[:preference][:email]
    user = User.find_by(login_token: session[:user_token])
    if user.instructor_preference.nil?
      ip = InstructorPreference.create(user: user)
      ip.preferences = {}
      ip.save!
      # puts ip
    end
    if ip.nil?
      ip = user.instructor_preference
    end
    ip.preferences[email] = rating
    ip.save!
  end
end
