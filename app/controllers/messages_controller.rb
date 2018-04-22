class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    
    if params[:limit] == nil || params[:limit].to_i < 0
      @messages = Message.all.order(created_at: :desc)
    else
      @messages = Message.order(created_at: :desc).limit(params[:limit])
    end
    json_response(@messages)
  end

  # POST /messages
  def create
    @message = Message.create!(message_params)
    json_response(@message, :created)
  end

  # GET /messages/:id
  def show
    json_response(@message)
  end

  # PUT /messages/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    # whitelist params
    params.permit(:channel, :created_at, :content, :autor)
  end

  def set_message
    @message = Message.find(params[:id])
  end 
end
