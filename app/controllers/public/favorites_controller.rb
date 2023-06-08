class Public::FavoritesController < ApplicationController
    def create
      @diary = Diary.find(params[:diary_id])
      @favorite = current_customer.favorites.new(diary_id: diary.id)
      @favorite.save
    end

    def destroy
      @diary = Diary.find(params[:diary_id])
      @favorite = current_customer.favorites.find_by(diary_id: diary.id)
      @favorite.destroy
    end
end
