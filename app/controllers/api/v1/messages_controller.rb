class Api::V1::MessagesController < ApplicationController
  swagger_controller :messages, "Messages Management"
  before_action :set_message, only: [:show, :update, :destroy]


  swagger_api :index do
    summary "Get all messages with flexible filters"
    notes "Retrieves all the messages, additionnal filters can be applied. Exception made of Duration and Limit, all the others filters impact the number of total result"
    param :query, :duration, :integer, :optional, "Retrieve the messages created over the last X minutes"
    param :query, :limit, :string, :optional, "Limit the number of result"
    response :ok, "Success", :Message
  end
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

  # POST /users
  swagger_api :create do
    summary "To create a message"
    notes "Implementation notes, such as required params, example queries for apis are written here."
    param :form, :channel, :string, :required, "Channel of the communication"
    param :form, :content, :string, :required, "Content of the communication"
    param :form, :direction,  :string, :required, "direction of the communication"
    param :form, :keyword, :string, :optional, "keyword of the communication"
    param :form, :created_by, :string, :required, "created_by of the communication"
    param :form, :created_at, :datetime, :optional, "created_at of the communication"
    param :form, :extra, :string, :optional, "extra bit of the communication"
    response :created
    response :unprocessable_entity
    response 500, "Internal Error"
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


    swagger_model :Message do
    description "A Message object."
    property :id, :integer, :optional, "Message Id"
    property :channel, :string, :required, "Channel used"
    property :content, :string, :required, "Content of the message"
    property :created_at, :datetime, :optional, "Creation time"
    property :created_by, :datetime, :required, "Author"
    property :direction, :string, :required, "Inbound/outbound"
    property :keyword, :string, :optional, "Keyword if any"
    property :extra, :string, :optional, "Extra information"
  end
end
