Rails.application.routes.draw do
 
  resources :categories
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
  
  root :to => 'site#home'
  
  get 'orderitems/index'

  get 'orderitems/show'

  get 'orderitems/new'

  get 'orderitems/edit'

  #this allows the application to communicate with the db for the required order items 
  #based on the current order and automathically setting up routes to do it
  resources :orders do 
    resources:orderitems
  end
  
  devise_for :users do 
    resources :orders
  end
  
  #this allows us to call the creatOrder method when we press the button
  get '/checkout' => 'cart#createOrder'
  get '/paid/:id' => 'static_pages#paid'
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
