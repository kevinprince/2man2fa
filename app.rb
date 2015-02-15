require 'bundler/setup'
require 'sinatra'
require 'dotenv'
require 'data_mapper'

Dotenv.load

DataMapper.setup(:default, ENV['DATABASE_URL'])

# Launchkey - Stores all the keys
class Key
  include DataMapper::Resource

  property :id,     Serial
  property :name,   String, unique: true
  property :token,  Text
end

# Launchkey - Stores all the keys
class Launch
  include DataMapper::Resource

  property :id,         Serial
  property :requester,  String
  property :requested,  String
  property :code,       String
end

DataMapper.finalize
Key.auto_upgrade!
Launch.auto_upgrade!

get '/' do
  'Awaiting launch instructions'
end

post '/enlist' do
  name = params['name']
  token = params['token']

  halt 412 if name.nil?
  halt 412 if name.length > 32
  halt 412 if token.nil?
  halt 412 if token.length > 32

  key = Key.create('name': name, 'token': token)

  halt 409 if key.saved? == false

  "the #{params['name']} launch key has been securely stored"
end

post '/launch' do
  message = params['Body'].downcase
  action = message.split(' ')[0]
  target = message.split(' ')[1]

  case action
  when 'launch'
    "Launch key for #{target} requested awaiting confirmation of order"
  when 'concur'
    'Order has been validated releasing the launch key - BOMBS AWAY!'
  when 'abort'
    'ABORT!!!! - Ok I have aborted the key release'
  end
end

error 409 do
  ''
end
