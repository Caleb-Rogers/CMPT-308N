-- Caleb Rogers, 9/21/2020, Lab 4: SQL Queries - The Subqueries Sequel 

-- 1. Get all the People data for people who are customers
select *
from people
where pid in (select pid
			   from customers);

-- 2. Get all the People data for people who are agents.
select *
from people
where pid in (select pid
			   from agents);
			   
-- 3. Get all of People data for people who are both customers and agents.
select *
from people
where pid in (select pid
			   from customers)
and pid in (select pid
			 from agents);
			   
-- 4. Get all of People data for people who are neither customers nor agents.
select *
from people
where pid not in (select pid
			       from customers)
and pid not in (select pid
			     from customers);
				   
-- 5. Get the ID of customers who ordered either product 'p01' or 'p07' (or both).
select pid
from customers
where pid in (select custId
				  from orders
				  where prodId = 'p01')
or pid in (select custId
		   from orders
		   where prodId = 'p07');

-- 6. Get the ID of customers who ordered both products 'p01' and 'p07'. List the IDs in order from highest to lowest. Include each ID only once.
select pid
from customers
where pid in (select custId
				  from orders
				  where prodId = 'p01')
and pid in (select custId
		     from orders
		     where prodId = 'p07')
order by pid desc;

-- 7. Get the first and last names of agents who sold products 'p05' or 'p07' in order by last name from Z to A.
select firstName, lastName
from people
where pid in (select pid
			   from agents
			   where pid in (select agentId
							  from orders
							  where prodId = 'p05'))
or pid in (select pid
			   from agents
			   where pid in (select agentId
							  from orders
							  where prodId = 'p07'))
order by lastName desc;

-- 8. Get the home city and birthday of agents booking an order for the customer whose pid is 001, sorted by home city from A to Z.
select homeCity, DOB
from people
where pid in (select agentId
			   from orders
			   where custId in (select custId
							      from orders
							      where custId = 001))
order by homeCity asc;
								  
-- 9. Get the unique ids of products ordered through any agent who takes at least one order from a customer in Toronto, sorted by id from highest to lowest. (This is not the same as asking for ids of products ordered by customers in Toronto.)
select prodId
from products
where prodId in (select prodId
				  from orders
				  where custId in (select pid
								    from customers
								    where pid in (select pid
												   from people
												   where homecity = 'Toronto')))
order by prodId asc;

-- 10. Get the last name and home city for all customers who place orders through agents in Teaneck or Santa Monica.
select lastName, homeCity
from people
where pid in (select pid
			   from customers
			   where pid in (select custId
							  from orders
							  where agentId in (select pid
											     from people
											     where homeCity = 'Teaneck')))
or pid in (select pid
			   from customers
			   where pid in (select custId
							  from orders
							  where agentId in (select pid
											     from people
											     where homeCity = 'Santa Monica')));