require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/eatery.rb')
require_relative('../models/deal.rb')
require_relative('../models/burger.rb')
require_relative('../models/burger_deal.rb')

get '/deals' do
  @deals = Deal.all
  erb( :"deals/index" )
end

get '/deals/new' do
  @burgers = Burger.all
  @eateries = Eatery.all
  erb( :"deals/new" )
end

post '/deals' do
  deal = Deal.new(params)
  deal.save

  for burger_id in params['burger_id']
    options = {}
    options['deal_id'] = deal.id
    options['burger_id'] = burger_id
    burger_deal = BurgerDeal.new(options)
    burger_deal.save
  end

  redirect to '/deals'
end

get '/deals/:id' do
  @deal = Deal.show(params[:id])
  erb( :"deals/show" )
end
