class Public::CommentsController < ApplicationController
  before_action :set_review

  def create
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user  # ログイン中のユーザーをコメントの投稿者として設定

    if @comment.save
      redirect_to store_review_path(@review.store, @review), notice: 'コメントが投稿されました。'
    else
      flash.now[:alert] = 'コメントの投稿に失敗しました。'+ @comment.errors.full_messages.join(", ")
      render 'public/reviews/show'
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
