Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :profiles do
    resources :answers

    collection do
      get :entrance
      get :empty
    end
  end

  namespace :interactions do
    post :ask
    get :reset
    post :ok
    post :no
    post :done
    get :list
  end

  namespace :friendships do
    post :like
    post :none
    post :block
  end

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    resources :missions
    resources :profiles do
      collection do
        get :me
      end
    end

    post "login" => "auth#login"
    post "logout" => "auth#logout"

  end

  root 'welcome#hello_world'

end
