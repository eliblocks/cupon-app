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
      redirect_to root_url
    else
      render 'new'
    end
  end


  private

  def rsvp_params
    params.require(:rsvp).permit(:name, :phone, :date, :url)
  end

end
