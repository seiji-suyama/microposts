class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :auth_user, only: [:edit, :update]

  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end  
    
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to the Sample App!"
       redirect_to @user 
    else
      render 'new'
    end
  end

  #UsersControllerのfollowingsにフォローしているユーザーを
  #followersにフォローされているユーザーを表示するメソッドを実装してください。
  def followings
    #users/:id/followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area, :profile)  
  end
  
  def auth_user
    if current_user != @user
      redirect_to root_url
      flash[:danger] = "不正なアクセス"
    end
  end
end