class PartyChannel < ApplicationCable::Channel
  def subscribed
    party = Party.find(params[:id])
    stream_for party
    # stream_from "some_channel"
  end

  # def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  # end
end
