Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
     namespace :v1 do
      resource :registrations
      resource :notes
      get '/notes_index', to: "notes#index"
      post '/scans', to: "scans#create"
      post '/login', to: "sessions#create"  
      post '/fb_login', to: "sessions#fb_create"
      delete '/logout', to: "sessions#delete"  
      # post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'
    end
    namespace :v2 do
      resource :registrations

      resource :books
      resource :quotes
      resource :comments

      get '/books/:id', to: "books#book_details"
      post '/scans', to: "scans#create"
      post '/login', to: "sessions#create"  
      post '/fb_login', to: "sessions#fb_create"
      delete '/logout', to: "sessions#delete"  
      # post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'
    end
  end

  
end
