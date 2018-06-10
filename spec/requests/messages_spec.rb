require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  # initialize test data 
  let!(:messages) { create_list(:message, 10) }
  let(:message_id) { messages.first.id }
  let(:message_keyword) { messages.first.keyword }
  let(:message_channel) { messages.first.channel }
  let(:message_direction) { messages.first.direction }

  # Test suite for GET /api/v1/messages
  describe 'GET /api/v1/messages' do
    # make HTTP get request before each example
    before { get '/api/v1/messages' }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq(10)
      expect(json['messages'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/messages?keyword=
  describe 'GET /api/v1/messages?keyword=xxx' do
    # make HTTP get request before each example
    before { get "/api/v1/messages?keyword=#{message_keyword}" }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq json['messages'].size
      expect(json['messages'].size).to be >= 1
      expect(json['messages'].size).to be < 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/messages?keyword=
  describe 'GET /api/v1/messages?channel=xxx' do
    # make HTTP get request before each example
    before { get "/api/v1/messages?channel=#{message_channel}" }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq json['messages'].size
      expect(json['messages'].size).to be >= 1
      expect(json['messages'].size).to be < 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/messages?keyword=
  describe 'GET /api/v1/messages?direction=xxx' do
    # make HTTP get request before each example
    before { get "/api/v1/messages?direction=#{message_direction}" }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq json['messages'].size
      expect(json['messages'].size).to be >= 1
      expect(json['messages'].size).to be < 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/messages?limit=
  describe 'GET /api/v1/messages?duration=30' do
    # make HTTP get request before each example
    before { get '/api/v1/messages?duration=3' }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq(10)
      puts json['messages']
      expect(json['messages'].size).to eq(0)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

# Test suite for GET /api/v1/messages?limit=
  describe 'GET /api/v1/messages?duration=5000' do
    # make HTTP get request before each example
    before { get '/api/v1/messages?duration=5000' }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq(10)
      expect(json['messages'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

   # Test suite for GET /api/v1/messages?limit=
  describe 'GET /api/v1/messages?limit=5' do
    # make HTTP get request before each example
    before { get '/api/v1/messages?limit=5' }

    it 'returns messages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['count']).to eq(10)
      expect(json['messages'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 

  # Test suite for GET /api/v1/messages/:id
  describe 'GET /api/v1/messages/:id' do
    before { get "/api/v1/messages/#{message_id}" }

    context 'when the record exists' do
      it 'returns the message' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(message_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:message_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  # Test suite for POST /api/v1/messages
  describe 'POST /api/v1/messages' do
    # valid payload
    time_now = DateTime.now
    let(:valid_attributes) { { 
      channel: 'Learn Elm', 
      created_at: time_now, 
      created_by: 'Lorem' , 
      content: 'Ipsum', 
      direction: 'Vorem', 
      extra: 'Ipra', 
      keyword: 'Aris'
      } }

    context 'when the request is valid' do
      before { post '/api/v1/messages', params: valid_attributes }

      it 'creates a message' do
        expect(json['channel']).to eq('Learn Elm')
        expect(json['created_at'].to_time).to eq(time_now.to_s.to_time)
        expect(json['created_by']).to eq('Lorem')
        expect(json['content']).to eq('Ipsum')
        expect(json['direction']).to eq('Vorem')
        expect(json['extra']).to eq('Ipra')
        expect(json['keyword']).to eq('Aris')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/messages', params: { 
        channel: 'Learn Elm', 
        created_at: DateTime.now, 
        created_by: 'Lorem' , 
        # content: 'Ipsum', 
        direction: 'Vorem', 
        extra: 'Ipra', 
        keyword: 'Aris'
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/messages/:id
  describe 'PUT /api/v1/messages/:id' do
    let(:valid_attributes) { { content: 'Shopping' } }

    context 'when the record exists' do
      before { put "/api/v1/messages/#{message_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/messages/:id
  describe 'DELETE /api/v1/messages/:id' do
    before { delete "/api/v1/messages/#{message_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end