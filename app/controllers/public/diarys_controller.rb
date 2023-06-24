class Public::DiarysController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def index
    @diarys = Diary.all.where(is_draft: :posted)
    @diary = Diary.new
        # 投稿が非公開かつ、投稿者がログインユーザーでない場合別のページにリダイレクト
    # if @diary.is_draft? && @diary.customer != current_customer
    #     # respond_to do |format|
    #     #format.html { redirect_to diarys_path, notice: 'このページにはアクセスできません' }
    #       redirect_to diarys_path(@diarys), notice: 'このページにはアクセスできません'
    #     # end
    # else

    #       render :show, notice: '投稿を閲覧できます'
    # # end
    # end
    # respond_to do |format|
    #   format.html do
        if @diary.is_draft? && @diary.customer != current_customer
          # redirect_to (request.referer || root_path)
          # redirect_to fallback_location: root_path, notice: 'このページにはアクセスできません'
        else
          # render :show, notice: '投稿を閲覧できます'
        end
    #   end
    # end
  end

  def show
    @current_customer = current_customer
    @diary = Diary.find(params[:id])
    @comment = Comment.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.score = Language.get_data(diary_params[:body])
    @diary.customer_id = current_customer.id

    if @diary.save
      #グラフに関するデータを取得しています。
      @diary_data = Diary.pluck(:score)
      redirect_to diary_path(@diary), notice: "投稿できました"
    else
      @diary = Diary.all
      render 'index'
    end
  end

  def edit
    # @diary = Diary.find(params[:id])
  end

  def update
    # @diary = Diary.find(params[:id])
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
    params.require(:diary).permit(:title, :body, :is_draft, sentiment_ids: [])
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
