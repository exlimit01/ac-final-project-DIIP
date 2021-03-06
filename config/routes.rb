Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :profiles do
    resources :answers

    collection do
      get :entrance
      get :empty
    end

    member do
        get :page
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

  namespace :v2_interactions do
    post :ok
    post :no
    post :done
    get :refresh
    get :list

    post :simu_matching_mission
    post :simu_go_out_mission
  end

  namespace :friendships do
    post :like
    post :none
    post :block
  end

  resources :rooms do
    resources :talks, :controller => "room_talks"
  end

  resources :profile_pictures  #for avatar

  post "like" => "like_answers#like"
  post "dislike" => "like_answers#dislike"

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

  root 'welcome#welcome_page'

  get 'rooms/show'

  #Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
