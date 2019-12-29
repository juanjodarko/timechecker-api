module V1
  class CheckoutsController < ApplicationController
    before_action :set_checkout, only: [:show, :update, :destroy]
    def index
      @checkouts = Checkout.all
      json_response(@checkouts)
    end

    def show
      json_response(@checkout)
    end

    def create
      @checkout = Checkout.create!(checkout_params)
      json_response(@checkout, :created)
    end

    def update
      @checkout.update(checkout_params)
      head :no_content
    end

    def destroy
      @checkout.destroy
      head :no_content
    end

    private

    def checkout_params
      params.permit(:user_id, :registrar_id, :time)
    end

    def set_checkout
      @checkout = Checkout.find(params[:id])
    end
  end
end
