Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :registrations
      post '/login', to: "sessions#create"  
      delete '/logout', to: "sessions#delete"  
    end
  end
end
