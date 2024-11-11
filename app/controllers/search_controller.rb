class SearchController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーのアクセスを制限

  def result
    @keyword = params[:keyword]
    @target = params[:target]

    if @target == "user"
      @results = User.where("family_name LIKE ? OR first_name LIKE ? OR family_name_kana LIKE ? OR first_name_kana LIKE ?", 
                            "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%")
    elsif @target == "store"
      @results = Store.where("name LIKE ? OR address LIKE ? OR tell_number LIKE ? OR price LIKE ? OR business_hours LIKE ? OR content LIKE ?",
                             "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%")
    else
      @results = []
    end
  end
end
