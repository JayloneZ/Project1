require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/burger.rb')


get '/eateries/:id/new' do
  @eatery_id = params[:id]
  erb( :"burgers/new" )
end

post '/eateries/:eatery_id' do
  Burger.new(params).save
  eatery_id = params[:eatery_id]
  redirect to ("/eateries/#{eatery_id}")
end
