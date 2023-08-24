Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get :dashboards, to: 'dashboards#profile'

  resources :bikes, only: %i[index show create new destroy] do
    resources :rentals, only: %i[create new]
  end

  resources :rentals do
    member do
      patch '/accept', to: 'rentals#accept'
    end
  end
end
