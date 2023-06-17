class Admin::HomesController < ApplicationController
  
  def top
    # 会員の一覧
    @customers = Customer.all.page(params[:page]).per(20)
  end
end
