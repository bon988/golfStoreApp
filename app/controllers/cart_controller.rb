class CartController < ApplicationController
  #the Cart in Ruby on Rails is based on the session[:cart} session variable.
  before_action :authenticate_user!
  
  #add method
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
  
  #clearCart method
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
  
  #remove method
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    
    redirect_to :root
  end
  
  #decrease method
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
  
  #createOrder method
  def createOrder
   # Step 1: Get the current user
   @user = User.find(current_user.id)
  
   # Step 2: Create a new order and associate it with the current user
   @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
   @order.save
  
   # Step 3: For each item in the cart, create a new item on the order!!
   @cart = session[:cart] || {} # Get the content of the Cart
   @cart.each do | id, quantity |
      item = Item.find_by_id(id)
      @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price=> item.price)
    @orderitem.save
  end
   @orders = Order.last
   #function to only choose order items for the last order
   @orderitems = Orderitem.where(order_id: Order.last)
   #sets session variable to nil and empty the cart (so cart is emptied when we go to the checkout)
   session[:cart] = nil
  end
  
end
