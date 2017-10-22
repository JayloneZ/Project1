require_relative '../db/sql_runner.rb'

class Burger

attr_reader :id, :eatery_id
attr_accessor :name, :price
def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @price = options['price'].to_f
  @eatery_id = options['eatery_id'].to_i
end

def self.all()
  sql = "
    SELECT * FROM burgers
  "
  db_burgers = SqlRunner.run(sql, nil)
  burgers = db_burgers.map {|burger| Burger.new(burger)}[0]
end

def self.delete_all()
  sql = "
    DELETE FROM burgers
  "
  SqlRunner.run(sql, nil)
end

def save()
  sql = "
    INSERT INTO burgers
    (
      name,
      price,
      eatery_id
    ) VALUES
    (
      $1,
      $2,
      $3
    )
    RETURNING *
  "
  values = [@name, @price, @eatery_id]
  @id = SqlRunner.run(sql, values)[0]['id']
end

def self.delete(id)
  sql = "
    DELETE FROM burgers
    WHERE id = $1
    RETURNING *
  "
  values = [id]
  (SqlRunner.run(sql, values)).map {|burger| Burger.new(burger)}
end

def update()
  sql = "
    UPDATE burgers SET
    (
      name,
      price
    ) =
    (
      $1,
      $2
    )
    WHERE id = $3
    RETURNING *
  "
  values = [@name, @price, @id]
  SqlRunner.run(sql, values)
  Burger.all
end

end
