require_relative '../db/sql_runner.rb'

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

def save()
  sql = "
    INSERT INTO burger_deals
    (
      deal_id,
      burger_id
    ) VALUES
    (
      $1,
      $2
    )
    RETURNING *
  "
  values = [@deal_id, @burger_id]
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
