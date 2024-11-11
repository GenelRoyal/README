class Public::ReviewsController < ApplicationController
  #before_action :authenticate_user!

  def create
    @store = Store.find(params[:store_id])
    @review = @store.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @store, notice: 'レビューが投稿されました。'
    else
      redirect_to @store, alert: 'レビューの投稿に失敗しました。'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :title, :image)
  end
end
