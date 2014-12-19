class OrderMailer < ActionMailer::Base 
 
  default from: 'Order Acknowledgement'

  def welcome_email(order,cart,hotel_name,discount,totalAmount,finalTotal)
    @order=order
    @cart=cart
    @hotel=hotel_name.hotel_Name
    @discount=discount
    @totalAmount=totalAmount
    @finalTotal=finalTotal
    mail(to: @order.email, subject: 'Order'+ ' '+ @order.orderId.to_s + ' '+ 'received')
  end
end
