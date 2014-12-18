Rails.application.routes.draw do

  # Generated when building topics views, handled by
  # resources :topics below 
  # get 'topics/index'

  # get 'topics/new'

  # get 'topics/show'

  # get 'topics/edit'

  devise_for :users
    resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create]
    end
  end
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
