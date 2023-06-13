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

  def destroy
    @diary = Diary.find(params[:id])

    # 管理者のみが投稿を削除できるようにする
    if admin_signed_in?
      @diary.destroy
      redirect_to admin_customers_path, notice: '投稿を削除しました。'
    else
      redirect_to diary_path(@diary), alert: 'この操作は許可されていません。'
    end
  end



private


  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email , :is_deleted)
  end
end
