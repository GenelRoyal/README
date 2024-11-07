class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice]= "会員情報を変更しました。"
      redirect_to users_mypage_path
    else
      flash[:alert]= "会員情報変更エラー"
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session

    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:family_name,
                                 :first_name,
                                 :family_name_kana,
                                 :first_name_kana,
                                 :email,
                                 :is_deleted,
                                 :image
                                 )
  end

  #URLでedit画面へ遷移できなくする
  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      redirect_to root_path , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
