class Admin::StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
      if @store.save
        flash[:notice] = '店舗登録成功です'
        redirect_to admin_store_path(@store.id)
      else
        flash[:alert] = '店舗登録エラー'
        render :new
      end
  end

  def index
    @stores = Store.page(params[:page]).per(10)
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
      if @store.update(store_params)
        flash[:notice] = "店舗登録編集完了です"
        redirect_to admin_store_path(@store)
      else
        flash[:alert] = "店舗登録編集エラー"
        render :edit
      end
  end

  private
  def store_params
    params.require(:store).permit(:name,
                                  :address,
                                  :tell_number,
                                  :price,
                                  :business_hours,
                                  :content,
                                  :image
                                  )
  end
end
