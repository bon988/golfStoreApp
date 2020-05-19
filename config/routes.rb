Rails.application.routes.draw do
 
  resources :items
  root 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  
  get '/login', to: 'user#login'
  get '/logout', to: 'user#logout'

  get '/clearcart', to: 'cart#clearCart'
  get '/cart', to: 'cart#index'
  get '/cart/:id', to: 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
  get '/cart/decrease/:id' => 'cart#decrease'
  
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
