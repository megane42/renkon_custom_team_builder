Rails.application.routes.draw do
  root to: "homes#index"

  resources :events, except: :destroy do
    resources :instant_entries, only: [:new, :create]
  end
end
