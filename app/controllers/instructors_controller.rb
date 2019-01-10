class InstructorsController < ApplicationController
  def index
    @instructors = User.where(auth_level: "instructor")
  end
  def add
    @email = params[:search][:query]
    @user = User.find_by(email: @email)
    if !@user
      redirect_to instructors_index_path, notice: "Could not find the user #{@email}"
    elsif @user.auth_level == "instructor" || @user.auth_level == "admin"
      redirect_to instructors_index_path, notice: "User's role is instructor or higher already..."
    else
      @user.auth_level = "instructor"
      @user.save!
      redirect_to instructors_index_path, notice: "Added #{@email} as an instructor! :)"
    end
  end
  def remove
    @email = params[:email]
    @user = User.find_by(email: @email)
    if !@user
      redirect_to instructors_index_path, notice: "Could not find the user #{@email}"
    elsif @user.auth_level == "admin"
      redirect_to instructors_index_path, notice: "User's role is admin..."
    else
      @user.auth_level = "student"
      @user.save!
      redirect_to instructors_index_path, notice: "Removed #{@email} as an instructor! :)"
    end
  end
end
