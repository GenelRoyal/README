class Public::StoresController < ApplicationController
  def index
    @stores_all = Store.all
    @stores = Store.page(params[:page]).per(8)
    @tag_list = Tag.all
  end
  
  def show
    @store = Store.find(params[:id])
  end
end
