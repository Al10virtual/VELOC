Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :lists, only: %i[show create new destroy] do
    resources :bookmarks, only: %i[show create new]
  end
  resources :bookmarks, only: %i[destroy]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :bikes

  resources :users do
    resources :rentals
  end

  resources :bikes, only: %i[show create new destroy] do
    resources :rentals
  end


end
