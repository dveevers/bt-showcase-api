Rails.application.routes.draw do
  get 'statistics/keywords'
  get 'statistics/channels'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :messages
    end
  end
end
