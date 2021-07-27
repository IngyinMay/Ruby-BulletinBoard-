class LoginController < ApplicationController
  def login

  end

  def actionLogin
    if params[:session][:email].blank? && params[:session][:password].blank?
      redirect_to login_path, notice: Messages::EMAIL_AND_PASSWORD_REQUIRE_VALIDATION
    elsif params[:session][:email].blank? && params[:session][:password] != nil
      redirect_to login_path, notice: Messages::EMAIL_REQUIRE_VALIDATION
    elsif params[:session][:email] != nil && params[:session][:password].blank?
      redirect_to login_path, notice: Messages::PASSWORD_REQUIRE_VALIDATION
    else 
      user = UserService.findByEmail(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to posts_path
      else 
        redirect_to login_path, notice: Messages::INVALID_EMAIL_OR_PASSWORD
      end
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to posts_path
  end

end
