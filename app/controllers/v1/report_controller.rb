class V1::ReportController < ApplicationController
  def index
    @attendance = User.includes(:attendances).all
    json_response(@attendance)
  end
end
