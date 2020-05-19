class CartController < ApplicationController
  #the Cart in Ruby on Rails is based on the session[:cart} session variable.
  
  def add
    # get the Id of the product
    id = params[:id]
    
  #if the cart is already been created, use existing cart else create a blank cart
  if session[:cart] then
    cart = session[:cart]
  else
    session[:cart] = {}
    cart = session[:cart]
  end
  
  #If the product is already added it increments by 1 else product set to 1
  if cart[id] then
    cart[id] = cart[id] + 1
  else
    cart[id]= 1
  end  
  
    redirect_to :action => :index
  
  end
  
  def clearCart
    #sets session variable to nil and bring back to index
    session[:cart] = nil
    redirect_to :action => :index
  end
  
  #The index action simply provides the cart ti be available as a @cart for the View
  #To get a full version we only need to work on the view. It uses the @cart variable to access the cart,
  #and is loosely based on the item index code.
  def index
    # passes a cart to display
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end  
  end
  
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    
    redirect_to :root
  end
  
  def decrease
    id = params[:id]
    cart = session[:cart]
    if cart[id] == 1 then
       cart.delete id
    else
     cart[id] = cart[id] - 1
    end
     #Taking us to cart index[view] page
      redirect_to :action => :index
  end
end
