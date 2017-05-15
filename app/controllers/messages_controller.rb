class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reply
    msg = params[:Body]
    from = params[:From]
    if  msg == '1'
      try_match
      if matched?
        notify_match(from)
      else
        affirm_confirmation(from)
      end
    else
      cancel_rsvp(from)
    end
  end

  def affirm_confirmation(to)
    body = "Thanks for confirming. We'll let you know if we find a match. If we don't find a match the day before your RSVP, we'll let you know that it's been canceled"
    send_message(to, body)
  end

  def cancel_rsvp(to)
    body = "Your RSVP has been canceled"
    send_message(to, body)
  end

  def send_message(to, body)
    client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )

    from = '+18159184589'

    client.messages.create(
      to: to,
      from: from,
      body: body
    )
  end

  def matched?
    !!Rsvp.find_by(phone: params[:From]).matched_rsvp
  end

  def try_match
    rsvp = Rsvp.find_by(phone: params[:From])
    another_rsvp = Rsvp.where(matched_rsvp: nil, url: rsvp.url, date: rsvp.date).first
    if another_rsvp
      rsvp.update(matched_rsvp: another_rsvp.id)
      another_rsvp.update(matched_rsvp: rsvp.id)
    end
  end

  def notify_match(to)
    rsvp = Rsvp.find_by(phone: to)
    other_rsvp = Rsvp.find_by(matched_rsvp: rsvp.id)
    msg = "#{rsvp.name} matched with #{other_rsvp.name} for #{rsvp.merchant}, #{rsvp.address} on #{rsvp.date}"
    send_message(rsvp.phone, msg)
    send_message(other_rsvp.phone, msg)
  end
end
