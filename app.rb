require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('models/eatery.rb')
require_relative('models/deal.rb')


get '/' do
  erb( :index )
end

get '/eateries' do
  @eateries = Eatery.all
  erb( :"eateries/index" )
end

get '/deals' do
  @deals = Deal.all
  erb( :"deals/index" )
end

get '/eateries/:id' do
  @eatery = Eatery.show(params[:id])
  erb( :"eateries/show" )
end

get '/deals/:id' do
  @deal = Deal.show(params[:id])
  erb( :"deals/show" )
end
