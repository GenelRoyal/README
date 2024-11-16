class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def create
    @store = Store.find(params[:store_id])
    @review = @store.reviews.build(review_params)
    @review.user = current_user
    tag_list = params[:review][:name].split(',')

    if @review.save
      @review.save_tags(tag_list)
      flash[:notice] = 'レビューが投稿されました。'
      redirect_to store_review_path(store_id: @store.id, id: @review.id)
    else
      flash[:alert] = 'レビューの投稿に失敗しました: ' + @review.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def index
    @tag_list = Tag.all
    @store = Store.find(params[:store_id])
    if params[:tag_id]
      @reviews = Tag.find(params[:tag_id]).reviews.where(store_id: @store.id).page(params[:page]).per(6)
    else
      @reviews = @store.reviews.page(params[:page]).per(6)
    end
  end

  def show
    @comments = @review.comments.includes(:user)
    @comment = @review.comments.build
    @tag_list = @review.tags.pluck(:name).join(',')
    @review_tags = @review.tags
  end

  def edit
    unless @review.user == current_user
      flash[:alert] = '他のユーザーのレビューは編集できません。'
      redirect_to store_review_path(@store, @review)
    end
  end

  def update
    if @review.update(review_params)
      flash[:notice] = 'レビューが更新されました。'
      redirect_to store_review_path(@store, @review)
    else
      flash[:alert] = 'レビューの更新に失敗しました: ' + @review.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @review.user == current_user
      @review.destroy
      flash[:notice] = 'レビューが削除されました。'
      redirect_to store_reviews_path(@store)
    else
      flash[:alert] = '他のユーザーのレビューは削除できません。'
      redirect_to store_review_path(@store, @review)
    end
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @reviews = @tag.reviews
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating, :image)
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
