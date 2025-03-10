class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    @items = Item.all
  end

  def help
  end

  def about
  end
  
  def paid
    #redirect_to "/cart/clear"
    flash[:notice] = 'Transaction Complete'
    @order = Order.last
    @order.update_attribute(:status , "Paid by User: #{current_user.email}")
    #"Paid by User:#{current_user.id} #{current_user.name} #{current_user.surname}")
  end
  
  def category
    catName = params[:title]
    @items = Item.where("category like ?", catName)
  end


  def aboutSend
        @order = Order.find(params[:id])
        @order.update_attribute(:status, "Paid with Paypal")
  end
end
