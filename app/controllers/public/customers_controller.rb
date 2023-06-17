class Public::CustomersController < ApplicationController
before_action :ensure_guest_user, only: [:edit]
      def show
        @customer = current_customer
        @diarys = @customer.diarys
        @diary = Diary.new
        @comment = Comment.new
      end

      def index
        @customer = current_customer
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

        def favorite
          @customer = Customer.find(params[:id])
          @favorites= Favorite.where(customer_id: @customer.id).pluck(:diary_id)
          @favorite_diaries = Diary.find(@favorites)
        end

        def guest_sign_in
          public = Public.guest
          sign_in public
          redirect_to public_path(public), notice: 'guestuserでログインしました。'
        end

      private

      def ensure_guest_user
          @customer = current_customer
        if @customer.pen_name == "guestuser"
          redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
        end
      end

      def customer_params
        params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :pen_name, :introduction, :is_published )
      end

end
