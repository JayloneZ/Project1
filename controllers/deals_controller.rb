require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/deal.rb')
require_relative('../models/burger.rb')
require_relative('../models/eatery.rb')
require_relative('../models/burger_deal.rb')

get '/deals' do
  @deals = Deal.all
  erb( :"deals/index" )
end

post '/deals/new' do
  redirect to ("deals/new")
end

get '/deals/new' do
  @burgers = Burger.all
  @eateries = Eatery.all
  erb( :"deals/new" )
end

post '/deals' do
  Deal.new(params).save
  BurgerDeal.new(params).save
  redirect to '/deals'
end

get '/deals/:id' do
  @deal = Deal.show(params[:id])
  erb( :"deals/show" )
end
