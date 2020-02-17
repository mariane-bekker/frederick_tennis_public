Rails.application.routes.draw do
  resources :games do
    post :score
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
