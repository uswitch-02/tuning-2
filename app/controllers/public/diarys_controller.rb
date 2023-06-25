class Public::DiarysController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def index
    @diarys = Diary.all.where(is_draft: :posted)
    @diary = Diary.new
        if @diary.is_draft? && @diary.customer != current_customer
        end
  end

  def show
    @current_customer = current_customer
    @diary = Diary.find(params[:id])
    @comment = Comment.new
    @new_diary = Diary.new
  end

  def create
    diary = Diary.new(diary_params)
    diary.score = Language.get_data(diary_params[:body])
    diary.customer_id = current_customer.id
    if diary.save
      flash[:notice] = "投稿できました"
      redirect_to action: :index
    else
     flash[:notice] = "投稿に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      redirect_to diarys_path(@diary), notice: "投稿を編集しました"
    else
      render "edit"
    end
  end

  def destroy
        @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diarys_path, notice: "投稿を削除しました"
  end




private

  def diary_params
    params.permit(:title, :body, :is_draft, sentiment_ids: [])
  end

  def article_params
    params.require(:article).permit(:body)
  end

# 日記の所有者だけが日記の編集や削除などの特定のアクションを実行できるようにする
  def ensure_correct_customer
    @diary = Diary.find(params[:id])
    unless @diary.customer == current_customer
      redirect_to diarys_path
    end
  end
end
