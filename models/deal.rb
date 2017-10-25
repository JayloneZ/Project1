require_relative '../db/sql_runner.rb'
require_relative 'eatery.rb'
require_relative 'burger.rb'

class Deal

attr_reader :id, :eatery_id
attr_accessor :name, :day, :discount_decimal
def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @day = options['day'].to_i
  @discount_decimal = options['discount_decimal'].to_f
  @eatery_id = options['eatery_id'].to_i
end

def self.all()
  sql = "
    SELECT * FROM deals
  "
  db_deals = SqlRunner.run(sql, nil)
  deals = db_deals.map {|deal| Deal.new(deal)}
  return deals
end

def self.delete_all()
  sql = "
    DELETE FROM deals
  "
  SqlRunner.run(sql, nil)
end

def save()
  sql = "
    INSERT INTO deals
    (
      name,
      day,
      discount_decimal,
      eatery_id
    ) VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *
  "
  values = [@name, @day, @discount_decimal, @eatery_id]
  @id = SqlRunner.run(sql, values)[0]['id']
end

def self.delete(id)
  sql = "
    DELETE FROM deals
    WHERE id = $1
    RETURNING *
  "
  values = [id]
  (SqlRunner.run(sql, values)).map {|deal| Deal.new(deal)}
end

def self.show(id)
  sql = "
    SELECT * FROM deals
    WHERE id = $1
  "
  values = [id]
  Deal.new(SqlRunner.run(sql, values)[0])
end

def update()
  sql = "
    UPDATE deals SET
    (
      name,
      day,
      discount_decimal
    ) =
    (
      $1,
      $2,
      $3
    )
    WHERE id = $4
    RETURNING *
  "
  values = [@name, @day, @discount_decimal, @id]
  SqlRunner.run(sql, values)
  Deal.all
end

def find_eatery()
  sql = "
    SELECT * FROM eateries
    WHERE id = $1
  "
  values = [@eatery_id]
  eatery = Eatery.new(SqlRunner.run(sql, values)[0])
end

def show_burgers()
  sql = "
    SELECT burgers.* FROM burgers
    INNER JOIN burger_deals ON burgers.id = burger_deals.burger_id
    INNER JOIN deals ON deals.id = burger_deals.deal_id
    WHERE burger_deals.deal_id = $1
  "
  values = [@id]
  burgers = SqlRunner.run(sql, values).map {|burger| Burger.new(burger)}
end

def day_name()
  case @day
  when 1
    return "Monday"
  when 2
    return "Tuesday"
  when 3
    return "Wednesday"
  when 4
    return "Thursday"
  when 5
    return "Friday"
  when 6
    return "Saturday"
  when 7
    return "Sunday"
  end
end

end
