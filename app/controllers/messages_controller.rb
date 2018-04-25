class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index

    @messages = Message.all
    
    @messages = @messages.where('keyword' => params[:keyword]) unless params[:keyword] == nil
    @messages = @messages.where('direction' => params[:direction]) unless params[:direction] == nil
    @messages = @messages.where('created_by' => params[:created_by]) unless params[:created_by] == nil
    @messages = @messages.where('channel' => params[:channel]) unless params[:channel] == nil

    @count = @messages.count

    @messages = @messages.where('created_at >= ?', params[:duration].to_i.minutes.ago) unless params[:duration] == nil || params[:duration].to_i < 0  
    @messages = @messages.limit(params[:limit]) unless params[:limit] == nil || params[:limit].to_i < 0

    @messages = @messages.order(created_at: :desc)
    json_response(
      {
        'count': @count,
        'messages': @messages
      }
    )
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
    params.permit(:channel, :created_at, :content, :created_by, :direction, :keyword, :extra)
  end

  def set_message
    @message = Message.find(params[:id])
  end 
end
