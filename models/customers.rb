require_relative('../db/sql_runner.rb')
require_relative('./films.rb')
require_relative('./tickets.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = 'INSERT INTO customers (name, funds)
          VALUES ($1, $2)
          RETURNING id'
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM customers'
    customer_hash = SqlRunner.run(sql)
    customers = customer_hash.map {|hash| Customer.new(hash)}
    return customers
  end

  def update
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def buying_ticket(price)
    sql = 'UPDATE customers SET funds = $1'
    deduction = @funds - price
    values = [deduction]
    SqlRunner.run(sql, values)
  end

end
