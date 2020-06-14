use shop;

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select distinct users.* from users join orders on users.id = orders.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select p.*, c.name catalog from products p join catalogs c on p.catalog_id = c.id;

-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

create database flights;

use flights;

create table cities(
city_id serial primary key,
label varchar(255),
name varchar(255));

create table flights(
id serial,
city_from varchar(255),
city_to varchar(255),
city_from_id bigint unsigned not null,
city_to_id bigint unsigned not null,
primary key (city_from_id, city_to_id), 
foreign key (city_from_id) references cities(city_id),
foreign key (city_to_id) references cities(city_id));

insert cities(label, name)
values
('moscow', 'москва'),
('novgorod', 'новгород'),
('rostov', 'ростов'),
('london', 'лондон');

insert flights(id, city_from, city_to, city_from_id, city_to_id)
values
('1', 'moscow', 'london', '1', '4'),
('2', 'moscow', 'novgorod', '1', '2'),
('3', 'rostov', 'london', '3', '4');

select fl1.id, fl1.city_from, fl2.city_to from 
(select f.id, c.name city_from
from flights f join cities c where city_from_id = city_id) fl1
join
(select f.id, c.name city_to
from flights f join cities c where city_to_id = city_id) fl2 
on fl1.id = fl2.id;




