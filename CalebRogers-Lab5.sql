-- 1. Show all the People data (and only people data) for people who are customers. Use joins this time; no subqueries.
select * -- need only ppl data!
from people P, customers C
where P.pid = C.pid;

-- 2. Show all the People data (and only the people data) for people who are agents. Use joins this time; no subqueries.
select * -- need only ppl data!
from people P, agents A
where P.pid = A.pid;

-- 3. Show all People and Agent data for people who are both customers and agents. Use joins this time; no subqueries.
select * -- Only ppl and agent
from people P, agents A, customers C
where P.pid = C.pid
  and P.pid = A.pid;

-- 4. Show the first name of customers who have never placed an order. Use subqueries.
select firstName
from people
where pid in (select pid
			   from customers
			   where pid not in (select custId
								  from orders));

-- 5. Show the first name of customers who have never placed an order. Use one inner and one outer join.


-- 6. Show the id and commission percent of Agents who booked an order for the Customer whose id is 008, sorted by commission percent from low to high. Use joins; no subqueries.


-- 7. Show the last name, home city, and commission percent of Agents who booked an order for the customer whose id is 001, sorted by commission percent from high to low. Use joins.


-- 8. Show the last name and home city of customers who live in the city that makes the fewest different kinds of products. (Hint: Use count and group by on the Products table. You may need limit as well.)


-- 9. Show the name and id of all Products ordered through any Agent who booked at least one order for a Customer in Chicago, sorted by product name from A to Z. You can use joins or subqueries. Better yet, do it both ways and impress me.


-- 10. Show the first and last name of customers and agents living in the same city, along with the name of their shared city. (Living in a city with yourself does not count, so exclude those from your results.)