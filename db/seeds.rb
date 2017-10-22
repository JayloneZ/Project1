require 'pry'
require_relative '../models/eatery.rb'
require_relative '../models/burger.rb'
require_relative '../models/deal.rb'
require_relative '../models/burger_deal.rb'

BurgerDeal.delete_all
Burger.delete_all
Deal.delete_all
Eatery.delete_all

eatery1 = Eatery.new({
  'name' => 'Sandys Burger Joint',
  'address' => 'CodeClan Edinburgh',
  'url' => 'N/A'
})
eatery1.save()

deal1 = Deal.new({
  'name' => 'Tuesdays Premium Double Deluxe Meats Package',
  'day' => '2',
  'discount_decimal' => '.65',
  'eatery_id' => eatery1.id
})
deal1.save()

burger1 = Burger.new({
  'name' => 'Mucho Meats Deluxe Burger',
  'price' => '6.95',
  'eatery_id' => eatery1.id
})
burger1.save()

burger1_deal1 = BurgerDeal.new({
  'burger_id' => burger1.id,
  'deal_id' => deal1.id
})
burger1_deal1.save()

binding.pry()
nil
