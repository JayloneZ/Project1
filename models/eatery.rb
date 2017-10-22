require_relative '../db/sql_runner.rb'

class Eatery

attr_reader :id
attr_accessor :name, :address, :url
def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @address = options['address']
  @url = options['url']
end

def self.all()
  sql = "
    SELECT * FROM eateries
  "
  db_eateries = SqlRunner.run(sql, nil)
  eateries = db_eateries.map {|eatery| Eatery.new(eatery)}[0]
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
      url
    ) VALUES
    (
      $1,
      $2,
      $3
    )
    RETURNING *
  "
  values = [@name, @address, @url]
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

def update()
  sql = "
    UPDATE eateries SET
    (
      name,
      address,
      url
    ) =
    (
      $1,
      $2,
      $3
    )
    WHERE id = $4
    RETURNING *
  "
  values = [@name, @address, @url, @id]
  SqlRunner.run(sql, values)
  Eatery.all
end

end
