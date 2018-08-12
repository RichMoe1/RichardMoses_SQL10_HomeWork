use sakila;

# 1a
select first_name, last_name from actor;

# 1b
select upper(concat(first_name,"  ", last_name)) from actor;

# 2a
select actor_id, first_name, last_name from actor where first_name like 'Joe%';

# 2b
select actor_id, first_name, last_name from actor where last_name like '%GEN%';

# 2c
select actor_id, first_name, last_name from actor where last_name like '%LI%'
order by last_name, first_name;

# 2d
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

# 3a
alter table actor add description blob;

# 3b
alter table actor drop column description;

# 4a
select count(*) as count, last_name from actor
group by last_name;

# 4b
select count(*) as count, last_name from actor 
group by last_name
having count(*) >= 2;

# 4c
update actor 
set first_name = 'HARPO',
	last_name = 'WILLIAMS'
where first_name = 'GROUCHO' 
and last_name = 'WILLIAMS'
and actor_id = 172;

# 4d
update actor 
set first_name = 'GROUCHO'
where first_name = 'HARPO' 
and actor_id = 172;

# 5a
SHOW CREATE TABLE address;

# 6a
select sta.first_name, sta.last_name, addr.address
from staff sta
inner join address addr
on sta.address_id = addr.address_id;

# 6b
select sum(py.amount), sta.first_name, sta.last_name
from payment py
inner join staff sta
on sta.staff_id = py.staff_id
where payment_date between '2005-08-1 00:00:00' and '2005-09-01 00:00:00'
group by sta.first_name, sta.last_name;

# 6c
select f.title, a.first_name, a.last_name
from film f
inner join film_actor fa
on fa.film_id = f.film_id
inner join actor a
on a.actor_id = fa.actor_id;


# 6d
select count(*) from inventory
where film_id in (select film_id from film where title = 'Hunchback Impossible');

# 6e
select sum(p.amount), c.first_name, c.last_name
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by c.first_name, c.last_name
order by c.last_name;

# 7a
select title from film where (title like 'K%'
or title like 'Q%')
and language_id in (select language_id from language where name = 'English');

# 7b
select first_name, last_name from actor
where actor_id in (select actor_id from film_actor where film_id in (select film_id from film where title = 'Alone Trip'));

# 7c
select c.first_name, c.last_name, c.email, co.country
from customer c
inner join address a
on a.address_id = c.address_id
inner join city ci
on ci.city_id = a.city_id
inner join country co
on co.country_id = ci.country_id
where co.country = 'Canada';

# 7d
select f.title, c.name
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
where c.name = 'Family';

# 7e
select count(r.rental_id), f.title
from rental r
inner join inventory i
on i.inventory_id = r.inventory_id
inner join film f
on f.film_id = i.film_id
group by f.title
order by count(r.rental_id) desc;

# 7f
select sum(p.amount) as profits, s.store_id
from payment p
inner join staff s
on s.staff_id = p.staff_id
inner join store st
on st.store_id = s.store_id
group by s.store_id
order by sum(p.amount) desc;

# 7g
select s.store_id, c.city, co.country
from store s
inner join address a
on a.address_id = s.address_id
inner join city c
on c.city_id = a.city_id
inner join country co
on co.country_id = c.country_id;

# 7h
select sum(p.amount) as Gross_Revenue, c.name as Genre
from payment p
inner join rental r
on r.rental_id = p.rental_id
inner join inventory i
on i.inventory_id = r.inventory_id
inner join film_category fc
on i.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

# 8a
create view vw_Top_Five_Geners_By_Gross

as

select sum(p.amount) as Gross_Revenue, c.name as Genre
from payment p
inner join rental r
on r.rental_id = p.rental_id
inner join inventory i
on i.inventory_id = r.inventory_id
inner join film_category fc
on i.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

# 8b
select * from vw_Top_Five_Geners_By_Gross;

# 8c
drop view vw_Top_Five_Geners_By_Gross;
































