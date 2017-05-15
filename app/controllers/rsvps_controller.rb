class RsvpsController < ApplicationController


  def new
    @rsvp = Rsvp.new
    @address = params[:address]
    @merchant = params[:merchant]
    @url = params[:deal_url]
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.save
      request_confirmation(params[:rsvp][:phone], params[:merchant], params[:address])
      flash[:success] = "RSVP sent! You will receive a confirmation text"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:name, :phone, :date, :url, :merchant, :address)
  end

  def request_confirmation(phone, merchant, address)
    from = '+18159184589'
    to = phone
    body = "Please confirm your cupon RSVP for #{ merchant } at #{ address }"

    client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )

    client.messages.create(
      to: to,
      from: from,
      body: body
    )
  end
end
