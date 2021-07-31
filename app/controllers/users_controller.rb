class UsersController < ApplicationController
  add_breadcrumb "User List", :users_path
  before_action :authorized?

  # function :index
  # show user list
  # @return [<Type>] <users>
  #
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

  # function : new_user
  # create user
  # @return [<Type>] <user>
  def new_user
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

  # function :show
  # show user detail
  # @return [<Type>] <user>
  #
  def show
    add_breadcrumb "User Detail", :user_path
    @user = UserService.getUserByID(params[:id])
  end

  # function :edit
  # show edit user
  # @return [<Type>] <edit user>
  #
  def edit
    add_breadcrumb "User Detail", :user_path
    add_breadcrumb "Edit User", :edit_user_path
    @user = UserService.getUserByID(params[:id])
  end

  #
  # function :update
  # update user
  # @return [<Type>] <redirect>
  #
  def update
    @user = UserService.getUserByID(params[:id])
    @is_user_update = UserService.updateUser(@user, user_params)
    if @is_user_update
      redirect_to @user
    else
      render :edit
    end
  end

  #
  # function destroy
  #
  # @return [<Type>] <description>
  #
  def destroy
    @user = UserService.getUserByID(params[:id])
    UserService.destroyUser(@user)
    redirect_to users_path
  end

  # function :profile
  # show profile
  # @return [<Type>] <current user>
  #
  def profile
    add_breadcrumb "Profile", :profile_users_path
    @user = current_user
  end

  # function :edit_profile
  # show edit profile page
  # @return [<Type>] <current user>
  #
  def edit_profile
    add_breadcrumb "Profile", :profile_users_path
    add_breadcrumb "Edit Profile", :edit_profile_users_path
    @user = current_user
  end

  #
  # function :update_profile
  # update user profile
  # @return [<Type>] <redirect>
  #
  def update_profile
    @user = current_user
    @is_update_profile = UserService.updateProfile(@user, user_params)
    if @is_update_profile
      redirect_to profile_users_path
    else
      render :edit_profile
    end
  end

  #
  # function :edit_password
  # show edit password 
  # @return [<Type>] <description>
  #
  def edit_password
    add_breadcrumb "Profile", :profile_users_path
    add_breadcrumb "Change Password", :edit_password_users_path
  end

  #
  # function :change_password
  # change user password
  # @return [<Type>] <redirect>
  #
  def change_password
    if params[:password].blank? && params[:password_confirmation].blank?
      redirect_to edit_password_users_path, notice: Messages::PASSWORD_AND_CONFIRM_PASSWORD_REQUIRED
    elsif params[:password].blank? && params[:password_confirmation] != nil
      redirect_to edit_password_users_path, notice: Messages::PASSWORD_REQUIRE_VALIDATION
    elsif params[:password] != nil && params[:password_confirmation].blank?
      redirect_to edit_password_users_path, notice: Messages::PASSWORD_CONFIRMATION_REQUIRED
    elsif params[:password] != params[:password_confirmation]
      redirect_to edit_password_users_path, notice: Messages::PASSWORD_AND_CONFIRM_PASSWORD_NOT_THE_SAME
    else
      @user = current_user
      @is_update_password = UserService.updatePassword(@user, params[:password])
      if @is_update_password
        redirect_to profile_users_path
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
