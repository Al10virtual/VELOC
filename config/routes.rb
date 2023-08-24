Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get :dashboards, to: 'dashboards#profile'
  
  get 'profile/edit', to: 'dashboards#edit_profile', as: 'edit_profile'
  patch 'profile', to: 'dashboards#update_profile', as: 'update_profile'


  resources :bikes, only: %i[index show create new destroy] do
    resources :rentals, only: %i[create new]
  end

  resources :rentals do
    member do
      patch '/accept', to: 'rentals#accept'
      patch '/deny', to: 'rentals#deny'
    end
  end
end
