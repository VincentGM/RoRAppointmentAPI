Rails.application.routes.draw do
  resources :schedules, only: [:index, :show, :create, :destroy] do
    resources :appointments, only: [:show, :create, :destroy]
  end

  resources :appointments, only: [:index]
end
