class Public::HomesController < ApplicationController
  
  def top
    @stores = Store.order(created_at: "DESC").limit(4)
  end
  
  def about
  end
end
