require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/deal.rb')
require_relative('../models/burger.rb')

get '/deals' do
  @deals = Deal.all
  erb( :"deals/index" )
end

get '/deals/:id' do
  @deal = Deal.show(params[:id])
  @burgers = Deal.show_burgers
  erb( :"deals/show" )
end
