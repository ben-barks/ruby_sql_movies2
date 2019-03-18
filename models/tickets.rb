require_relative('../db/sql_runner.rb')
require_relative('./films.rb')
require_relative('./customers.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    # @limit = options['limit'].to_i
  end

  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id)
          VALUES ($1, $2)
          RETURNING id'
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM tickets'
    ticket_hash = SqlRunner.run(sql)
    tickets = ticket_hash.map {|hash| Ticket.new(hash)}
    return tickets
  end

  def update
    sql = 'UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def film
    sql = 'SELECT * FROM films WHERE id = $1'
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def customer
  sql = 'SELECT * FROM customers WHERE id = $1'
  values = [@customer_id]
  customer = SqlRunner.run(sql, values).first
  return Customer.new(customer)
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def ticket_count_per_customer
    sql = 'SELECT customer_id FROM tickets WHERE customer_id = $1'
    values = [@customer_id]
    tickets = SqlRunner.run(sql, values).count
    return tickets, @customer_id
  end

  # def limited_seats
  #   sql = 'SELECT * FROM customers WHERE id = $1'
  #   values = [@customer_id]
  #   amount = SqlRunner.run(sql, values).count
  #   delete() if amount > @limit
  # end

end
