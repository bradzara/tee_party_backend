class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)

    render :index
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
    render :show
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
  end

  private
    def conversation_params
      params.permit(:sender_id, :receiver_id)
    end
end
