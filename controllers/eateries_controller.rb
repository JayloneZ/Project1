require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/eatery.rb')

get '/eateries' do
  @eateries = Eatery.all
  erb( :"eateries/index" )
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

post '/eateries/:id' do
  eatery_id = params[:eatery_id]
  redirect to ("/eateries/#{eatery_id}/new")
end

get '/eateries/:id/new' do
  @eatery_id = params[:id]
  erb( :"burgers/new" )
end

post '/eateries/:eatery_id' do
  Burger.new(params).save
  eatery_id = params[:eatery_id]
  redirect to ("/eateries/#{eatery_id}")
end
