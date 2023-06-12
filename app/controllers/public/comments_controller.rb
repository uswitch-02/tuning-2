class Public::CommentsController < ApplicationController
    def create
      @diary = Diary.find(params[:diary_id])
      @comment = current_customer.comments.new(comment_params)
      @comment.diary_id = @diary.id
      if@comment.save
        render :create
      else
        render 'diarys/show'
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
    end

    private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
