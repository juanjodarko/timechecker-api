class V1::AccountsController < ApplicationController
  skip_before_action :authorize_request, only: :create
  def create
    @account = Account.new(account_params)
    @account.owner = User.new(user_params)
    @account.save!
    json_response(@account.owner, :created)
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain)
  end

  def user_params
    params.require(:account).require(:owner_attributes).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
