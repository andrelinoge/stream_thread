Rails.application.routes.draw do
  root to: "channels#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]


  resources :online_users, only: [] do
    collection do
      get :users
    end
  end
  
  resources :channels, only: [:index] do
    resources :chats, only: [:index, :create] do
      collection do
        get :chat
        get :exit_chatroom
      end
    end
  end
end
