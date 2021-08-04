Rails.application.routes.draw do
  root to: "homes#index"

  resources :events, except: :destroy
end
