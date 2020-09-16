-- Caleb Rogers, 9/16/20, Lab 3: Getting Started with SQL Queries

-- Query 1: List the order number and total dollars of all orders.
select ordernum, totalusd
from orders;

-- Query 2: List the last name and home city of people whose prefix is "Dr.".
select lastname, homecity
from people
where prefix = 'Dr.';

-- Query 3: List id, name, and price of products with quantity more than 1007.
select prodid, name, priceusd
from products
where qtyonhand > '1007';

-- Query 4: List the first name and home city of people born in the 1950s.
select firstname, homecity
from people
where dob >= '1950-01-01' and dob < '1960-01-01';

-- Query 5: List the prefix and last name of people who are not "Mr.".
select prefix, lastname
from people
where not prefix = 'Mr.';

-- Query 6: List all fields for products in neither Dallas nor Duluth that cost US$3 or more.
select *
from products
where not city = 'Dallas' and not city = 'Duluth' and priceusd >= '3';

-- Query 7: List all fields for orders in March.
select *
from orders
where dateordered >= '2020-03-01' and dateordered < '2020-04-01';

-- Query 8: List all fields for orders in February of us$20,000 or more.
select *
from orders
where dateordered >= '2020-02-01' and dateordered < '2020-03-01' and totalusd >= '20000';

-- Query 9: List all orders from the customer whose id is 007.
select *
from orders
where custid = '007';

-- Query 10: List all orders from the customer whose id is 005.
select *
from orders
where custid = '005';
