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
