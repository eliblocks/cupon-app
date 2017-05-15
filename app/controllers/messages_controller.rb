class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reply
    response = Twilio::TwiML::Response.new do |r|
      r.Sms "Thanks for confirming."
    end
    render :xml => response.to_xml
  end
end
