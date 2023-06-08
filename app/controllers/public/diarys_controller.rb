class Public::DiarysController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @diarys = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_comment = Comment.new
  end

  def create
    @diary = Diary.new(diary_params)
  end

  def edit
    @diary = Diary.find(params[:id])
    if @diary.save
      redirect_to book_path(@diary), notice: "投稿に成功しました."
    else
      render 'show'
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @book.update(diary_params)
      redirect_to diarys_edit_path(@diary), notice: "投稿を編集しました"
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
    params.require(:diary).permit(:title, :body)
  end
  def ensure_correct_customer
    @diary = Diary.find(params[:id])
    unless @diary.customer == current_customer
      redirect_to diarys_path
    end
  end
end
