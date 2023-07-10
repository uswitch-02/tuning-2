class Public::RelationshipsController < ApplicationController

    def create
      customer = Customer.find(params[:customer_id])
      current_customer.follow(customer)
      redirect_to request.referer
    end

    def destroy
      customer = Customer.find(params[:customer_id])
      current_customer.unfollow(customer)
      redirect_to request.referer
    end

    def followings
      customer = Customer.find(params[:customer_id])
      @customer_name = customer
      @customer = customer.followings
    end

    def followers
      customer = Customer.find(params[:customer_id])
      @customer_name = customer
      @customer = customer.followers
    end
end
