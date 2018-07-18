Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :registrations
      post '/login', to: "sessions#create"  
      delete '/logout', to: "sessions#delete"  
    end
  end
end
