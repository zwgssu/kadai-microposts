class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました"
      redirect_to @user
    else
      flash[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    
    if @user.update(user_params)
      flash[:success] = "編集が完了しました"
      redirect_to @user
    else
      flash[:danger] = "編集に失敗しました"
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  private
  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :self_introduction)
  end
  
end