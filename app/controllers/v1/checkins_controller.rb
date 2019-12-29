module V1
  class CheckinsController < ApplicationController
    before_action :set_checkin, only: [:show, :update, :destroy]

    def index
      @checkins = Checkin.all
      json_response(@checkins)
    end

    def create
      @checkin = Checkin.create!(checkin_params)
      json_response(@checkin, :created)
    end

    def show
      json_response(@checkin)
    end

    def update
      @checkin.update(checkin_params)
      head :no_content
    end

    def destroy
      @checkin.destroy
      head :no_content
    end

    private

    def checkin_params
      params.permit(:user_id, :registrar_id, :time)
    end

    def set_checkin
      @checkin = Checkin.find(params[:id])
    end
  end
end
