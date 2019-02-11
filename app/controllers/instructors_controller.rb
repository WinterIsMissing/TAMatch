class InstructorsController < ApplicationController
  def index
    @instructors = User.where(auth_level: "instructor")
    @non_instructors = User.where.not(auth_level: ["admin", "instructor"])
  end
  def add
    @email = params[:search][:query]
    redirect_to instructors__add_path(email: @email)
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
  def _add
    @email = params[:email]
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
end
