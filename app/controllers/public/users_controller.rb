class Public::UsersController < ApplicationController
  #before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(6)
    #@store = Store.find(params[:store_id])
    #@reviews = @store.reviews.page(params[:page]).per(6)
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
    if @user.update(is_deleted: true)
      reset_session
      redirect_to new_user_registration_path, notice: "退会が完了しました。またのご利用をお待ちしております。"
    else
      redirect_to edit_user_path(@user), alert: "退会処理に失敗しました。再度お試しください。"
    end
  end

  def liked_reviews
    @user = User.find(params[:id])
    @liked_reviews = @user.liked_reviews.includes(:store)
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
