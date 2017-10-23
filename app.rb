require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('controllers/eateries_controller.rb')
require_relative('controllers/deals_controller.rb')

get '/' do
  erb( :index )
end
