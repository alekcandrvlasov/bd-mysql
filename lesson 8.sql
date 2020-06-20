-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

create database sample;
use sample;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

start transaction;

select * from shop.users where id = 1;
 
insert sample.users 
select * from shop.users where id = 1;

delete from shop.users where id = 1;
commit;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

use shop;

create view tp as
select products.name name_products,
(select catalogs.name from catalogs where catalogs.id = products.catalog_id) name_catalogs
from products;

select * from tp;

-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 

delimiter //
drop function if exists hello//
create function hello()
returns varchar(255) deterministic
begin
declare hour int;
set hour = date_format(now(), "%H");
if (hour >= 6 and hour < 12) then
return "Доброе утро";
elseif (hour >= 12 and hour < 18) then
return "Добрый день";
elseif (hour >= 0 and hour < 6) then
return "Доброй ночи";
else
return "Добрый вечер";
end if;
end //

delimiter ;

select hello();

-- Триггеры

delimiter //
drop trigger if exists products_name//
create trigger products_name before insert on shop.products
for each row
begin
if (new.name is null and new.description is null) then
signal sqlstate '45000' set message_text = 'Value is null';
end if;
end//

delimiter ;

-- Проверяем работу триггера
select * from products;

insert products(`description`)
values('Процессор для ноутбуков'); 
insert products(`description`)
values(null);






