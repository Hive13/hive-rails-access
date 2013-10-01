class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 1000

    customer = Stripe::Customer.create(
      :email => current_member.email,
      :description => "#{current_member.fname} #{current_member.lname} (#{current_member.id})",
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => '20 Soda Credits',
      :currency    => 'usd'
    )

    mixpanel.track 'SodaCredit', { :amount => 10.00 }
    if current_user.vend_credits = nil
      um = Member.find(current_member.id)
      um.stripeToken = customer.id
      um.vend_credits = 20
      um.save
    else
      um = Member.find(current_member.id)
      um.stripeToken = customer.id
      um.vend_credits += 20
      um.save
    end



  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
