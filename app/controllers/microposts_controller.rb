class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user_micropost, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "メッセージを投稿しました"
      redirect_to root_url
    else
      flash[:danger] = "メッセージの投稿に失敗しました"
      render "toppages/index"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "メッセージを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user_micropost
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
