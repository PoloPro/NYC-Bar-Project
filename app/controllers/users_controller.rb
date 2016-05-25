class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :follow, :unfollow]
  before_filter :set_current_user, only: [:show, :follow, :unfollow]
  before_filter :validate_authorization_for_user, only: [:edit, :update]
  protect_from_forgery except: :show
  # GET /users/1
  def show
    @reviews = @user.reviews.sort_by{|r| r.likes.count}
    respond_to :html, :js
  end

  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def index
    @users = User.all
  end

  # PATCH/PUT /users/1
  def update
    # 2015-07-23 RICHARD: Updated to use strong parameters
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def follow
    @current_user.follow(@user)
    respond_to :js
  end

  def unfollow
    @current_user.stop_following(@user)
    respond_to :js
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      redirect_to destroy_user_session_path if params[:id] == "sign_out"
      @user = User.find(params[:id])
    end

    def set_current_user
      @current_user = current_user
    end

    def validate_authorization_for_user
     redirect_to root_path unless @user == current_user
   end

    # 2015-07-23 RICHARD: Added to implement strong parameters
    def user_params
      params.require(:user).permit(:name, :username, :email, :picture, :admin, :provider, :of_age)
    end

  end

