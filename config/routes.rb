Rails.application.routes.draw do

  resources :clients do
    resources :pets do
      resources :pet_histories
    end
  end

  root 'clients#index'
  
end
