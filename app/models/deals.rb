require 'httparty'

class Deals

  def initialize(division, limit)
    @division = division
    @api_url = 'https://partner-api.groupon.com/deals.json?'
    @token = 'US_AFF_0_201236_212557_0'
    @limit = limit

  end

  def get_deals
    response = HTTParty.get("#{@api_url}tsToken=#{@token}&division_id=#{@division}&filters=category2:restaurants&offset=0&limit=#{@limit}")
    response.parsed_response['deals'].map { |d_params| Deal.new(d_params) }
  end
end
