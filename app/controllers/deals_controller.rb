class DealsController < ApplicationController
  require 'httparty'
  def index
    @division = params[:division] || "san-francisco"
    deals_object = Deals.new(@division, 25)
    @deals = deals_object.get_deals
  end
end

