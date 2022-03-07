Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    
    # app
    # n/a, app added on provision. Maybe add ability to 

    # comment
    get "/comments" => "comments#index"
    get "/comments/:id" => "comments#show"
    post "/comments" => "comments#create"
    patch "/comments/:id" => "comments#update"
    delete "/comments/:id" => "comments#destroy"

    # issue
    get "/issues" => "issues#index"
    get "/issues/:id" => "issues#show"
    post "/issues" => "issues#create"
    patch "/issues/:id" => "issues#update"
    delete "/issues/:id" => "issues#destroy"

    # location
    get "/locations" => "locations#index"

    # step
    get "/steps" => "steps#index"
    get "/steps/:id" => "steps#show"
    post "/steps" => "steps#create"
    patch "/steps/:id" => "steps#update"
    delete "/steps/:id" => "steps#destroy"
  
    # user_issues
    # Should be done on issue controller

    # user
    get "/users" => "users#index"
    get "/users/:id" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    post "/sessions" => "sessions#create"

  end
end
