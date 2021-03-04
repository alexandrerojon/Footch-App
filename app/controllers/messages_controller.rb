class MessagesController < ApplicationController

  def create
    @party = Party.find(params[:party_id])
    @message = Message.new(message_params)
    @message.party = @party
    @message.user = current_user
    if @message.save
      PartyChannel.broadcast_to(
        @party,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to party_path(@party, anchor: "message-#{@message.id}")
    else
      render "party/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
