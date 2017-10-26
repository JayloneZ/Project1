require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/eatery.rb')
require_relative('../models/deal.rb')

get '/eateries' do
  @eateries = Eatery.all
  erb( :"eateries/index" )
end

post '/eateries/new' do
  redirect to ("eateries/new")
end

get '/eateries/new' do
  erb( :"eateries/new" )
end

post '/eateries' do
  Eatery.new(params).save
  redirect to '/eateries'
end

get '/eateries/:id' do
  @eatery = Eatery.show(params[:id])
  erb( :"eateries/show" )
end
