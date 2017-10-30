require 'pg'

class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect({
#       dbname: 'burger_deals',
#       host: 'localhost'
        dbname: 'dc74ajbi6vlrjj',
        host: 'ec2-23-23-221-255.compute-1.amazonaws.com',
        port: '5432',
        user: 'yndeqfvadjfzmj',
        password: '9cee201532e8005cba42e22374e45d26edef006522234edbee0f5bafc9618e80',
      })
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close()
    end
    return result
  end

end
