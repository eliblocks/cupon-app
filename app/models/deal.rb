class Deal
  attr_accessor :title, :url, :division, :price, :discount, :display_title, :merchant, :image_url, :address

  def initialize(params)
    @title = params['shortAnnouncementTitle']
    @url = params['dealUrl']
    @price = params['options'][0]['price']['amount']
    @division = params['division']['name']
    @discount = params['options'][0]['discountPercent']
    @merchant = params['merchant']['name']
    @image_url = params['grid6ImageUrl']
    if params['options'][0]['redemptionLocations'][0]
      @address = params['options'][0]['redemptionLocations'][0]['streetAddress1']
    end

    @display_title = "#{@discount}% Off #{@title}"

  end
end
