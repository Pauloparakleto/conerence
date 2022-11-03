Rails.application.routes.draw do
  root to: 'tracks#index'
  resources :talks do
    collection do
      post :create_by_csv
    end
  end
  resources :tracks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
