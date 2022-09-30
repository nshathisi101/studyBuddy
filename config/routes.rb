Rails.application.routes.draw do
  resources :bmesseages
  resources :lessons
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  post 'join/:id', to: "lessons#join", as: "join_lesson"

  post 'comment/', to: "lessons#comment", as: "join_comment"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "lessons#index"
end
