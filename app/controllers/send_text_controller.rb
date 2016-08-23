class SendTextController < ApplicationController

  def index
  end

#I need to keep this in a loop in a way to send the messages to all the users within the group

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = "AC3a80958af3a028cfc67db78aaba8461b"
    twilio_token = "29e47689c9ebf2f63f187bbad91d99b2"
    twilio_phone_number = "61437081575"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Join this group at #{ group_url(@group.id) }. It gets sent to #{number_to_send_to}"
    )
  end


end
