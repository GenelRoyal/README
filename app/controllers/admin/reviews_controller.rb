class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_review, only: [:show, :destroy]

  def index
    @reviews = Review.includes(:user, :store).order(created_at: :desc).page(params[:page])
  end

  def show
    # 詳細ページ表示用のデータはset_reviewで取得済み
  end

  def destroy
    if @review.destroy
      flash[:notice] = "レビューが削除されました。"
    else
      flash[:alert] = "レビューの削除に失敗しました。"
    end
    redirect_to admin_reviews_path
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end
