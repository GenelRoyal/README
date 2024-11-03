class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(8)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報更新しました"
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "会員情報更新エラー"
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:family_name,
                                 :first_name,
                                 :family_name_kana,
                                 :first_name_kana,
                                 :email,
                                 :is_deleted
                                 )
  end
end
