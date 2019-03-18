require_relative('../models/films.rb')
require_relative('../models/customers.rb')
require_relative('../models/tickets.rb')

require('pry')

Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({"name" =>"Marla", "funds" => 50})
customer1.save()
customer2 = Customer.new({"name" => "Tyler", "funds" => 100})
customer2.save()
customer3 = Customer.new({"name" => "Cornelius", "funds" => 20})
customer3.save()

film1 = Film.new({"title" => "Fightclub", "price" => 10,})
film1.save()
film2 = Film.new({"title" => "Death Becomes Her", "price" => 5,})
film2.save()
film3 = Film.new({"title" => "Fire Walk With Me", "price" => 20,})
film3.save()

ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket1.save()
p ticket1.ticket_count_per_customer()
customer1.buying_ticket(film2.price)

ticket2 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket2.save()
p ticket2.ticket_count_per_customer()
customer2.buying_ticket(film1.price)

ticket3 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})
ticket3.save()
p ticket3.ticket_count_per_customer()
customer3.buying_ticket(film3.price)

customer3.name = 'Jack'
customer3.update()

film2.title = 'First Wives Club'
film2.update()

ticket1.film_id = film1.id
ticket1.update()
customer1.buying_ticket(film1.price)

ticket1.film()

ticket1.customer()












binding.pry
nil
