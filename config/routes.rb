Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :bikes, only: %i[index show create new destroy] do
    resources :rentals, only: %i[create new]
  end
end
