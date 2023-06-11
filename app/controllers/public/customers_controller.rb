class Public::CustomersController < ApplicationController

      def show
        @customer = current_customer
        @diarys = @customer.diary
        @diary = Diary.new
      end
      
      def index
        @customers = Customer.all
      end

      def edit
         @customer = current_customer
      end

      def update
        @customer = current_customer
        if @customer.update(customer_params)
          flash[:notice] = "登録情報を編集しました"
          redirect_to customer_path
        else
          flash[:alert] = "編集に失敗しました"
          render "edit"
        end
      end


      def confirm
      end

      def withdraw
        @customer = current_customer
        # 退会のボタンを押した場合
        if @customer.update(member_status: true)
          reset_session
          redirect_to root_path
        else
          flash[:alert] = "編集に失敗しました"
          render :edit
        end
      end

      private

      def customer_params
        params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :pen_name, :introduction )
      end

end
