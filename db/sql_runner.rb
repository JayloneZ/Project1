require 'pg'

class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect({
        dbname: ENV['dbname'],
        host: ENV['host'],
        port: ENV['port'],
        user: ENV['user'],
        password: ENV['password']
      })
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close()
    end
    return result
  end

end
