-- Практическое задание по теме Оптимизация запросов

use shop;

drop table if exists logs;
create table logs (
  id serial,
  created_at datetime,
  table_name enum('users', 'products', 'catalogs') not null,
  t_id bigint unsigned,
  table_content varchar(255)
) engine = Archive;

delimiter //
drop trigger if exists logs_users//
create trigger logs_users after insert on shop.users
for each row
begin
insert into shop.logs (created_at, table_name, t_id, table_content)
values (
now(), 'users', new.id, new.name);
end//

drop trigger if exists logs_products//
create trigger logs_products after insert on shop.products
for each row
begin
insert into shop.logs (created_at, table_name, t_id, table_content)
values (
now(), 'products', new.id, new.name);
end//

drop trigger if exists logs_catalogs//
create trigger logs_catalogs after insert on shop.catalogs
for each row
begin
insert into shop.logs (created_at, table_name, t_id, table_content)
values (
now(), 'catalogs', new.id, new.name);
end//

delimiter ;

-- Практическое задание по теме “NoSQL”
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

set IP1 0 -- задаем ключ-значение для определенного ip адреса
incr IP1 -- увеличиваем значение при запросе с определенного IP адреса

-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

mset user1 user1@mail.ru user2 user2@mail.ru user3 user3@mail.ru -- задаем ключ-значение для пользователя и его адреса эл почты
get user1 -- поиск эл адреса по пользлвателю

mset user1@mail.ru user1 user2@mail.ru user2 user3@mail.ru user3 -- задаем ключ-значение для пользователя и его адреса эл почты
get user1@mail.ru -- поиск пользователя по эл адресу

-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

db.shop.insert({products: {name: 'Intel Core i3-8100', description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', price: '7890.00'}}, {catalogs: {name: 'Процессоры'}})




