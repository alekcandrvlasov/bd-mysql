use shop;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

update users 
set 
`created_at` = now(), `updated_at` = now()
where `id` > 0;

select * from users;

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

alter table users 
modify created_at varchar(255), 
modify updated_at varchar(255);

update users 
set 
`created_at` = '20.10.2017 8:10', `updated_at` = '20.10.2017 8:10'
where `id` > 0;

update users 
set 
`created_at` = 
concat(substring(`created_at`,7,4),'-',substring(`created_at`,4,2),'-',substring(`created_at`,1,2),substring(`created_at`,11,5)),
`updated_at` = 
concat(substring(`updated_at`,7,4),'-',substring(`updated_at`,4,2),'-',substring(`updated_at`,1,2),substring(`updated_at`,11,5))
-- convert(datetime, updated_at, 20) так и не понял можно это применить или нет и как
where `id` > 0;

alter table users 
modify created_at datetime, 
modify updated_at datetime;

-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

INSERT storehouses_products
  (`storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`)
VALUES
  ('1', '1', 300, now(), now()),
  ('2', '2', 127, now(), now()),
  ('3', '2', 47, now(), now()),
  ('3', '3', 712, now(), now()),
  ('4', '4', 0, now(), now()),
  ('2', '5', 479, now(), now()),
  ('2', '6', 506, now(), now());

select * from storehouses_products;

select `value`, 
case `value`
when 0
then '2'
else '1' 
end value_type
from storehouses_products 
order by value_type, `value`
;

-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

select * from users
where 
date_format(birthday_at, '%b') in ('may','august')
;

-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

select * from catalogs
where id in (5, 1, 2)
order by
field(id,5,1,2);

-- Подсчитайте средний возраст пользователей в таблице users

select name, timestampdiff(year,birthday_at, now()) age from users; -- Посмотрим возвраст клиентов

select round(avg(timestampdiff(year,birthday_at, now())),0) avg_age from users; -- Вычислим средний возраст


-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- Посмотрим на какие дни приходятся дни рождения в этом году
select name, date_format(concat(date_format(now(),'%Y'),'-',substring(`birthday_at`,6,5)), '%a') birthday from users;

-- Подсчитаем кол-во дней рождения по дням
select date_format(concat(date_format(now(),'%Y'),'-',substring(`birthday_at`,6,5)), '%a') `day`, count(*) `count`
from users group by `day`;

