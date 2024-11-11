class SearchController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーのアクセスを制限

  def result
    @keyword = params[:keyword]
    @target = params[:target]

    if @target == "user"
      @results = User.where("name LIKE ?", "%#{@keyword}%")
    elsif @target == "store"
      @results = Store.where("content LIKE ?", "%#{@keyword}%")
    else
      @results = []
    end
  end
end
end
