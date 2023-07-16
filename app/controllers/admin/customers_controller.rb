class Admin::CustomersController < ApplicationController

  def index
    #会員者情報、1ページの表示件数10件
    @customers = Customer.all.page(params[:page]).per(10)
    # @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @diarys = @customer.diarys
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
    flash[:notice] = "編集に成功しました"
  end

  private


  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email , :is_deleted)
  end
end
