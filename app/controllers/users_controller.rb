class UsersController < ApplicationController
  add_breadcrumb "User List", :users_path
  def index
    @users = UserService.getAllUsers
  end

  # function : new
  # show user create
  # @return [<Type>] <description>
  def new
    add_breadcrumb "Create User", :new_user_path
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @is_user_create = UserService.createUser(@user)
    if @is_user_create
      if current_user 
        redirect_to users_path
      else 
        redirect_to login_path
      end
    else
      render :new
    end
  end

  def show
    add_breadcrumb "User Detail", :user_path
    @user = UserService.getUserByID(params[:id])
  end

  def edit
    add_breadcrumb "User Detail", :user_path
    add_breadcrumb "Edit User", :edit_user_path
    @user = UserService.getUserByID(params[:id])
  end

  def update
    @user = UserService.getUserByID(params[:id])
    @is_user_update = UserService.updateUser(@user, user_params)
    if @is_user_update
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = UserService.getUserByID(params[:id])
    UserService.destroyUser(@user)
    redirect_to users_path
  end

  def profile
    add_breadcrumb "Profile", :profile_path
    @user = current_user
  end

  def edit_profile
    add_breadcrumb "Profile", :profile_path
    add_breadcrumb "Edit Profile", :edit_profile_path
    @user = current_user
  end

  def update_profile
    @user = current_user
    @is_update_profile = UserService.updateProfile(@user, user_params)
    if @is_update_profile
      redirect_to profile_path
    else
      render :edit_profile
    end
  end

  def edit_password
    add_breadcrumb "Profile", :profile_path
    add_breadcrumb "Change Password", :password_path
  end

  def change_password
    if params[:password].blank? && params[:password_confirmation].blank?
      redirect_to password_path, notice: Messages::PASSWORD_AND_CONFIRM_PASSWORD_REQUIRED
    elsif params[:password].blank? && params[:password_confirmation] != nil
      redirect_to password_path, notice: Messages::PASSWORD_REQUIRE_VALIDATION
    elsif params[:password] != nil && params[:password_confirmation].blank?
      redirect_to password_path, notice: Messages::PASSWORD_CONFIRMATION_REQUIRED
    elsif params[:password] != params[:password_confirmation]
      redirect_to password_path, notice: Messages::PASSWORD_AND_CONFIRM_PASSWORD_NOT_THE_SAME
    else
      @user = current_user
      @is_update_password = UserService.updatePassword(@user, params[:password])
      if @is_update_password
        redirect_to profile_path
      end
    end
  end


  private
  # set user parameters
  # @return [<Type>] <description>
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :phone, :address, :birthday, :super_user_flag, :role)
  end
end
