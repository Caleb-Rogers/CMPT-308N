-- Lab 3 Queries
select ordernum, totalusd
from orders;

select lastname, homecity
from people
where prefix = 'Dr.';

select prodid, name, priceusd
from products
where qtyonhand > 1007;

select firstname, homecity
from people
where dob >= '1950-01-01' and dob < '1960-01-01';

select prefix, lastname
from people
where not prefix = 'Mr.';

select *
from products
where not city = 'Dallas' and not city = 'Duluth' and priceusd >= '3';

select *
from orders
where dateordered >= '2020-03-01' and dateordered < '2020-04-01';

select *
from orders
where dateordered >= '2020-02-01' and dateordered < '2020-03-01' and totalusd >= '20000';

select *
from orders
where custid = '007';

select *
from orders
where custid = '005';