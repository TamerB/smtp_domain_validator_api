# spec/requests/validation_requests_spec.rb
require 'rails_helper'

RSpec.describe 'ValidationRequest API', type: :request do
  # initialize test data
  #let!(:four_requests) { create_list(:validation_request, 3) }
  #let(!(:five_requests) { create_list(:validation_requests, 5)})
  #let(:validation_request_id) { four_requests.first.id }

  # Test suite for GET /validation_requests
  #describe 'GET /validation_requests' do
    # make HTTP get request before each example
  #  before { get '/validation_requests' }

  #  it 'returns validation_requests' do
      # Note `json` is a custom helper to parse JSON responses
  #    expect(json).not_to be_empty
  #    expect(json.size).to eq(4)
      # or in case of :five_requests
      # expect(json.size).to eq(5)
  #  end

  #  it 'returns status code 200' do
  #    expect(response).to have_http_status(200)
  #  end
  #end

  # Test suite for GET /validation_requests/:id
  #describe 'GET /validation_requests/:id' do
  #  before { get "/validation_requests/#{validation_request_id}" }

  #  context 'when the record exists' do
  #    it 'returns the validation_request' do
  #      expect(json).not_to be_empty
  #      expect(json['id']).to eq(validation_request_id)
  #    end

  #    it 'returns status code 200' do
  #      expect(response).to have_http_status(200)
  #    end
  #  end

  #  context 'when the record does not exist' do
  #    let(:validation_request_id) { 100 }

  #    it 'returns status code 404' do
  #      expect(response).to have_http_status(404)
  #    end

  #    it 'returns a not found message' do
  #      expect(response.body).to match(/Couldn't find ValidationRequest/)
  #    end
  #  end
  #end

  # Test suite for POST /validation_requests
  describe 'POST /validation_requests' do

    context 'when the request has no email' do
      before { post '/validation_requests', params: {}}

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to eq("Bad Request... No email to validate!")
      end
    end

    context 'when the request is valid' do
      before { post '/validation_requests', params: { email: 'tamer.bhgt@gmail.com' } }

      it 'creates a validation_request' do
        expect(json['message']).to eq("Valid SMTP domain!")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/validation_requests', params: { email: 'test@test.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to eq("Invalid SMTP domain!")
      end
    end

    #context 'when the request exceed 5 requests limit' do
    #  before { post '/validation_requests', params: { email: 'tamer.bhgt@gmail.com'} }

    #  it 'returns status code 405' do
    #    expect(response).to have_http_status(405)
    #  end

    #  it 'returns a validation failure message' do
    #    expect(json['message']).to eq("Validation Request denied: At most 5 api requests per second are allowed!")
    #  end
    #end
  end
end
