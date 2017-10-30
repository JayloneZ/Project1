require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

require_relative('controllers/eateries_controller.rb')
require_relative('controllers/deals_controller.rb')
require_relative('controllers/burger_controller.rb')

get '/' do
  erb( :index )
end
