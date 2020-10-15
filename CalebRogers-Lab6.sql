-- Caleb Rogers, 10/11/2020, Lab 6: Interesting and Painful Queries

-- 1. Display the cities that makes the most different kinds of products.
select city
from products
group by city
having count(city) >= all (select count(city) 
						     from products 
						     group by city);

-- 2. Display the names of products whose priceUSD is at or above the average priceUSD, in reverse-alphabetical order.
select name as productNames
from products
where priceUSD >= (select avg(priceUSD) from products)
order by name desc;

-- 3. Display the customer last name, product id ordered, and the totalUSD for all orders made in March, sorted by totalUSD from high to low.
select lastName, prodId, totalUSD
from people P
full outer join orders O on P.pid = O.custId
where dateordered >= '2020-03-01' and dateordered < '2020-04-01'
order by totalUSD desc;

-- 4. Display the last name of all customers (in reverse alphabetical order) and their total ordered, and nothing more. (Hint: Use coalesce to avoid showing NULLs.)
select lastName, coalesce(totalUSD, 0) as totalOrdered
from people P
inner join customers C on P.pid = C.pid
full outer join orders O on C.pid = O.custId
order by lastName desc;

-- 5. Display the names of all customers who bought products from agents based in Teaneck along with the names of the products they ordered, and the names of the agents who sold it to them.
select distinct P1.firstName as custFirstName, P1.lastName as custLastName, Pr.name as prodName, P2.firstName as agentFirstName, P2.lastName as agentLastName
from products Pr 
inner join orders O1 on Pr.prodId = O1.prodId
inner join orders O2 on O1.agentId = O2.agentId
inner join customers C on O1.custId = C.pid
inner join people P1 on C.pid = P1.pid
inner join people P2 on O2.agentId = P2.pid
where P1.homeCity = 'Teaneck';

-- 6. Write a query to check the accuracy of the totalUSD column in the Orders table. This means calculating Orders.totalUSD from data in other tables and comparing those values to the values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any. If there are any incorrect values, explain why they are wrong.
select O.*
from orders O
inner join products Pr on O.prodId = Pr.prodId
inner join customers C on O.custId = C.pid
where O.totalUSD != (select ROUND(((O.quantityOrdered*Pr.priceUSD)-((O.quantityOrdered*Pr.priceUSD)*(discountPct/100))), 2))
-- Explaination: orderNum '1017' is calculated to have a accurate totalUSD of '25643.89' but within the insert statement for
-- orderNum '1017', the value inserted to it's totalUSD is '25643.88', which is different from the value in the CAP database
-- snapshot, which is also '25643.89'.

-- 7. Display the first and last name of all customers who are also agents.
select firstName, lastName
from people P
inner join customers C on P.pid = C.pid
inner join agents A on C.pid = A.pid;

-- 8. Create a VIEW of all Customer and People data called PeopleCustomers. Then another VIEW of all Agent and People data called PeopleAgents. Then "select *" from each of them in turn to test.
create view PeopleCustomers
as
select *
from people P
where pid in (select pid
			   from customers C);
create view PeopleAgents
as
select *
from people
where pid in (select pid
			   from agents);
			  
select * from PeopleCustomers;
select * from PeopleAgents;		   
			  
-- 9. Display the first and last name of all customers who are also agents, this time using the views you created.
select firstName, lastName
from PeopleCustomers
intersect
select firstName, lastName
from PeopleAgents;
  
-- 10. Compare your SQL in #7 (no views) and #9 (using views). The output is the same. How does that work? What is the database server doing internally when it processes the #9 query?
--
-- In my query for #7, I had used two joins that had the first join display the people data from only the people from the customers table and then the second join filtered the people table of
-- customers to those who were both a customer and an agent. This was accomplished in my #9 query as well by using my two created views from query #8. The first view created a virtual table
-- of people who are customers, and the second view made one of people who are agents. The output from query #7 was replicated in query #9 and this was accomplished by intersecting the two
-- created views, and the person who was part of both the PeopleCustomers view and the PeopleAgents view, was the resulting person who was the one who was a customer and also an agent.
-- The database server when processing the #9 query internally accesses the system catalog for the two virtual tables created from the views. After accessing these, the two virtual tables
-- are then used and, within query #9, are intersected to produce the correct display of data.
		
		
-- 11. [Bonus] What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in SQL to demonstrate. (Feel free to use the CAP database to make your points here.)
--
-- The difference between a left outer join and a right outer join is that when using a left outer join, the data from the "left" table and only the data from the right table that matches the
-- left table is returned. For example, using left outer join to join the people table and the customers table, all the data from the previous FROM statement will be displayed, as well as the
-- data from the customers table that matches. The data from the customers table that doesnt match recieves null values. With a right outer join, the data from the "right" table and only the
-- data from the left table that matches is returned. For example, using the same query as previous but with a right outer join, all the data from customers table is displayed with the data
-- from the people table data that matches. This result displays only the five people who are customers, with the customer and people data that applies, rather than the left outer join which
-- would return all nine people and their people data from the people data, and its corresponding customer data that matches and assigns null values for those that do not match.
--
select *
from people P
left outer join customers C on P.pid = C.pid
--
select *
from people P
right outer join customers C on P.pid = C.pid
--
