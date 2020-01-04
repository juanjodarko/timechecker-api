Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    get 'report', to: 'report#index'
    post 'signup', to: 'accounts#create'
    resources :checkins
    resources :checkouts
  end

  post 'auth/login', to: 'authentication#authenticate'
end
