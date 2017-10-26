require_relative '../db/sql_runner.rb'
require_relative 'deal.rb'
require_relative 'burger.rb'

class Eatery

  attr_reader :id
  attr_accessor :name, :address, :url, :img_src
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @address = options['address']
    @url = options['url']
    @img_src = options['img_src']
  end

  def self.all()
    sql = "
      SELECT * FROM eateries
    "
    db_eateries = SqlRunner.run(sql, nil)
    eateries = db_eateries.map {|eatery| Eatery.new(eatery)}
    return eateries
  end

  def self.delete_all()
    sql = "
      DELETE FROM eateries
    "
    SqlRunner.run(sql, nil)
  end

  def save()
    sql = "
      INSERT INTO eateries
      (
        name,
        address,
        url,
        img_src
      ) VALUES
      (
        $1,
        $2,
        $3,
        $4
      )
      RETURNING *
    "
    values = [@name, @address, @url, @img_src]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.delete(id)
    sql = "
      DELETE FROM eateries
      WHERE id = $1
      RETURNING *
    "
    values = [id]
    (SqlRunner.run(sql, values)).map {|eatery| Eatery.new(eatery)}
  end

  def self.show(id)
    sql = "
      SELECT * FROM eateries
      WHERE id = $1
    "
    values = [id]
    Eatery.new(SqlRunner.run(sql, values)[0])
  end

  def update()
    sql = "
      UPDATE eateries SET
      (
        name,
        address,
        url,
        img_src
      ) =
      (
        $1,
        $2,
        $3,
        $4
      )
      WHERE id = $5
      RETURNING *
    "
    values = [@name, @address, @url, @img_src, @id]
    SqlRunner.run(sql, values)
    Eatery.all
  end

  def find_deals()
    sql = "
      SELECT * FROM deals
      WHERE eatery_id = $1
    "
    values = [@id]
    deals = (SqlRunner.run(sql, values)).map {|deal| Deal.new(deal)}
  end

  def find_burgers()
    sql = "
      SELECT * FROM burgers
      WHERE eatery_id = $1
    "
    values = [@id]
    burgers = (SqlRunner.run(sql, values)).map {|burger| Burger.new(burger)}
  end

end
