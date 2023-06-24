class Admin::DiarysController < ApplicationController


  def destroy
    @diary = Diary.find(params[:id])

    # 管理者のみが投稿を削除できるようにする
    if admin_signed_in?
      @diary.destroy
      redirect_to admin_customer_path(@diary.customer_id), notice: '投稿を削除しました。'
    else
      redirect_to admin_customer_path(@diary.customer_id), alert: 'この操作は許可されていません。'
    end
  end
end
