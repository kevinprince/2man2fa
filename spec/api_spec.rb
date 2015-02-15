# spec/api_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe 'The 2man2fa App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'awaits launch instructions' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Awaiting launch instructions')
  end

  describe '/enlist' do
    it 'enlists a tactical warhead launch key' do
      post '/enlist', 'name': 'github', 'token': 'iurrxu6waxicxu4n'
      expect(last_response).to be_ok
      expect(last_response.body).to eq(
        'the github launch key has been securely stored'
      )
    end

    it 'returns a 409 if the launch key exists' do
      post '/enlist', 'name': 'github', 'token': 'iurrxu6waxicxu4n'
      expect(last_response.status).to eq 409
    end

    it 'returns a 412 if the name is missing' do
      post '/enlist', 'token': 'iurrxu6waxicxu4n'
      expect(last_response.status).to eq 412
    end

    it 'returns a 412 if the name is longer than 32 chars' do
      post '/enlist', 'name': 'githubgithubgithubgithubgithubgithub', 'token': 'iurrxu6waxicxu4n'
      expect(last_response.status).to eq 412
    end

    it 'returns a 412 if the token is missing' do
      post '/enlist', 'name': 'github'
      expect(last_response.status).to eq 412
    end

    it 'returns a 412 if the token is longer than 32 chars' do
      post '/enlist', 'name': 'github', 'token': 'githubgithubgithubgithubgithubgithub'
      expect(last_response.status).to eq 412
    end

    it 'adds the launch key to the database' do
      "is a pending example"
    end

    it 'messages the principals the current launch code' do
      "is a pending example"
    end
  end

  describe '/launch' do
    describe 'a launch key request' do
      it 'confirms the request' do
        post '/launch', 'Body': 'launch github'
        expect(last_response).to be_ok
        expect(last_response.body).to eq(
          'Launch key for github requested awaiting confirmation of order'
        )
      end

      it 'messages the other principals to ask them to concur' do
        "is a pending example"
      end
    end

    describe 'an order confirmation' do
      it 'validates the order confirmation' do
        post '/launch', 'Body': 'concur awede'
        expect(last_response).to be_ok
        expect(last_response.body).to eq(
          'Order has been validated releasing the launch key - BOMBS AWAY!'
        )
      end

      it 'messages the original requestor the launch key' do
        "is a pending example"
      end

      it 'messages the other principals to notify them' do
        "is a pending example"
      end
    end

    describe 'an order cancellation' do
      it 'validates the order cancellation' do
        post '/launch', 'Body': 'abort awede'
        expect(last_response).to be_ok
        expect(last_response.body).to eq(
          'ABORT!!!! - Ok I have aborted the key release'
        )
      end
    end
  end
end
