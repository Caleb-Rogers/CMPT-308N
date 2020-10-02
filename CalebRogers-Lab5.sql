-- Caleb Rogers, 9/29/2020, Lab 5: SQL Queries - The Joins Three-quel

-- 1. Show all the People data (and only people data) for people who are customers. Use joins this time; no subqueries.
select p.*
from people P
inner join customers C on P.pid = C.pid;

-- 2. Show all the People data (and only the people data) for people who are agents. Use joins this time; no subqueries.
select p.*
from people P
inner join agents A on P.pid = A.pid;

-- 3. Show all People and Agent data for people who are both customers and agents. Use joins this time; no subqueries.
select p.*, a.*
from people P
inner join agents A on P.pid = A.pid
inner join customers C on A.pid = C.pid;

-- 4. Show the first name of customers who have never placed an order. Use subqueries.
select firstName
from people
where pid in (select pid
	      from customers
	      where pid not in (select custId
			        from orders));

-- 5. Show the first name of customers who have never placed an order. Use one inner and one outer join.
select distinct firstName
from people P
inner join customers C on P.pid = C.pid
left outer join orders O on C.pid != O.custId
where C.pid not in (select custId
		    from orders);

-- 6. Show the id and commission percent of Agents who booked an order for the Customer whose id is 008, sorted by commission percent from low to high. Use joins; no subqueries.
select distinct pid, commissionPct
from agents A
inner join orders O on A.pid = O.agentId
where custId = 008 
order by commissionPct asc;

-- 7. Show the last name, home city, and commission percent of Agents who booked an order for the customer whose id is 001, sorted by commission percent from high to low. Use joins.
select distinct lastName, homeCity, commissionPct
from people P
inner join agents A on P.pid = A.pid
inner join orders O on A.pid = O.agentId
where custId = 001
order by commissionPct desc;

-- 8. Show the last name and home city of customers who live in the city that makes the fewest different kinds of products. (Hint: Use count and group by on the Products table. You may need limit as well.)
select lastName, homeCity
from people P
inner join customers C on P.pid = C.pid
inner join products Pr on P.homeCity = Pr.city
where Pr.city in (select city
                  from products
                  group by city
                  order by count (prodId) asc
                  limit 1);

-- 9. Show the name and id of all Products ordered through any Agent who booked at least one order for a Customer in Chicago, sorted by product name from A to Z. You can use joins or subqueries. Better yet, do it both ways and impress me.
select Pr.name, Pr.prodId
from products Pr
inner join orders O on Pr.prodId = O.prodId
inner join agents A on O.agentId = A.pid
inner join customers C on O.custId = C.pid
inner join people P on P.pid = C.pid
where homeCity = 'Chicago'
order by name asc;

-- 10. Show the first and last name of customers and agents living in the same city, along with the name of their shared city. (Living in a city with yourself does not count, so exclude those from your results.)
select P.pid, firstName, lastName, homeCity
from people P
inner join customers C on P.pid = C.pid
where homeCity in (select homeCity
	           from people
	           group by homeCity 
		   order by count (homeCity) desc
		   limit 1)
union
select P.pid, firstName, lastName, homeCity
from people P
inner join agents A on P.pid = A.pid
where homeCity in (select homeCity
	           from people
	           group by homeCity 
	           order by count (homeCity) desc
		   limit 1);
