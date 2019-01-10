Rails.application.routes.draw do
  mount_roboto
  root to: 'home#index'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :account_activations, only: %i[edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :articles, only: %i[show new create edit update] do
    collection do
      post :preview
    end
    resources :stocks, only: %i[create destroy], format: :js
    resources :likes, only: %i[create destroy], format: :js
    resources :comments, only: %i[create update destroy]
  end

  resources :users do
    member do
      get :liked, to: 'users#show', as: :show
    end
  end

  resources :stocks, only: %i[index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
