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
  'url' => 'http://www.sandystavern.com/',
  'img_src' => '/images/sandy.png'
})
eatery1.save()

eatery2 = Eatery.new({
  'name' => 'Bobs Burgers',
  'address' => 'Burger Street',
  'url' => 'http://thebobsburgerexperiment.com/',
  'img_src' => '/images/bob.jpg'
})
eatery2.save()

deal1 = Deal.new({
  'name' => 'Tuesdays Premium Double Deluxe Meats Package',
  'day' => '2',
  'discount_decimal' => '0.65',
  'eatery_id' => eatery1.id
})
deal1.save()

deal2 = Deal.new({
  'name' => 'Wednesdays Premium Double Deluxe Meats Package',
  'day' => '3',
  'discount_decimal' => '0.50',
  'eatery_id' => eatery1.id
})
deal2.save()

deal3 = Deal.new({
  'name' => '15% off for first 2 customers',
  'day' => '2',
  'discount_decimal' => '0.15',
  'eatery_id' => eatery2.id
})
deal3.save()

burger1 = Burger.new({
  'name' => 'Mucho Meats Deluxe Burger',
  'price' => '6.90',
  'eatery_id' => eatery1.id
})
burger1.save()

burger2 = Burger.new({
  'name' => 'Chicken Cheese & Bacon',
  'price' => '8.99',
  'eatery_id' => eatery2.id
})
burger2.save()

burger3 = Burger.new({
  'name' => 'The Whoppar',
  'price' => '6.00',
  'eatery_id' => eatery2.id
})
burger3.save()

burger1_deal1 = BurgerDeal.new({
  'burger_id' => burger1.id,
  'deal_id' => deal1.id
})
burger1_deal1.save()

burger1_deal2 = BurgerDeal.new({
  'burger_id' => burger1.id,
  'deal_id' => deal2.id
})
burger1_deal2.save()

burger2_deal3 = BurgerDeal.new({
  'burger_id' => burger2.id,
  'deal_id' => deal3.id
})
burger2_deal3.save()

burger3_deal3 = BurgerDeal.new({
  'burger_id' => burger3.id,
  'deal_id' => deal3.id
})
burger3_deal3.save()

binding.pry
nil
