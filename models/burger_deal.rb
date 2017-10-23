require_relative '../db/sql_runner.rb'
require_relative 'burger.rb'
require_relative 'deal.rb'

class BurgerDeal

attr_reader :id, :deal_id, :burger_id
def initialize(options)
  @id = options['id'].to_i if options['id']
  @deal_id = options['deal_id'].to_i
  @burger_id = options['burger_id'].to_i
end

def self.all()
  sql = "
    SELECT * FROM burger_deals
  "
  db_burger_deals = SqlRunner.run(sql, nil)
  burger_deals = db_burger_deals.map {|burger_deal| BurgerDeal.new(burger_deal)}[0]
end

def self.delete_all()
  sql = "
    DELETE FROM burger_deals
  "
  SqlRunner.run(sql, nil)
end

def new_price()
  sql = "
    SELECT burgers.price, deals.discount_decimal FROM burgers
    INNER JOIN burger_deals
    ON burgers.id = burger_deals.burger_id
    INNER JOIN deals
    ON deals.id = burger_deals.deal_id
    WHERE deals.id = $1
  "
  values = [@deal_id]
  result = SqlRunner.run(sql, values)[0]
  new_price = result['price'].to_f * result['discount_decimal'].to_f
  @new_price = new_price.round(2)
end

def save()
  sql = "
    INSERT INTO burger_deals
    (
      deal_id,
      burger_id,
      new_price
    ) VALUES
    (
      $1,
      $2,
      $3
    )
    RETURNING *
  "
  values = [@deal_id, @burger_id, @new_price]
  @id = SqlRunner.run(sql, values)[0]['id']
end

def self.delete(id)
  sql = "
    DELETE FROM burger_deals
    WHERE id = $1
    RETURNING *
  "
  values = [id]
  (SqlRunner.run(sql, values)).map {|burger_deal| BurgerDeal.new(burger_deal)}
end

end
