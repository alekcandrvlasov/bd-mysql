USE languages_courses;

-- Определим кол-во пользователей, обучающихся на каждом курсе в порядке убывания

select c.name 'название курса', count(uc.user_id) 'кол-во студентов' 
from users_courses uc
join courses c on c.id = uc.courses_id
group by uc.courses_id order by count(uc.user_id) desc;

-- Определим 10 пользователей с максимальной оценкой за курсы

select u.firstname, u.lastname, uc.users_grade 'Оценка' 
from users_courses uc
join users u on u.id = uc.user_id
order by uc.users_grade desc limit 10;

-- Опеределим лучшего студента, изучающего английский язык на уровне С2

select c.name 'course', u.firstname, u.lastname, c.language, c.level, uc.users_grade 'Оценка' 
from users_courses uc
join users u on u.id = uc.user_id
join courses c on c.id = uc.courses_id
where c.level = 'C2' and c.language = 'ENGLISH'
order by uc.users_grade desc limit 1;

-- Определим общее кол-во пользователей

select count(id) from users;

-- Определим пользователей подписанных на книги, рассылки и видеопазлы

select distinct u.firstname, u.lastname
from users u
join users_books ub on u.id = ub.user_id
join users_mailing_lists um on u.id = um.user_id
join users_video_puzzle uv on u.id = uv.user_id
order by u.firstname;

-- Определим наиболее популярную книгу

select b.name 'книга', count(ub.user_id) 'кол-во подписчиков' 
from books b
join users_books ub on b.id = ub.books_id
group by b.id order by count(ub.user_id) desc limit 1;

-- Представления. 
-- Определим список пользователей, курсы, которые они проходят и их оценку на курсах

create view uc as
select u.firstname, u.lastname, c.name 'Курс', uc.users_grade 'Оценка' 
from users u 
left join users_courses uc on u.id = uc.user_id
join courses c on c.id = uc.courses_id
order by u.firstname;

-- Определим кол-во пользователей изучающих видеопазлы на различных языках

create view up as
select p.language 'Язык видеопазла', count(up.user_id) 'Кол-во пользователей'
from video_puzzle p 
join users_video_puzzle up on p.id = up.video_puzzle_id
group by p.language order by count(up.user_id);

-- Триггеры
-- Создадим триггер запрещающий вставлять дату окончания обучения меньше даты старта обучения

delimiter //
drop trigger if exists update_users_courses//
create trigger update_users_courses before insert on users_courses
for each row
begin
if (new.users_end_date < new.users_start_date) then
signal sqlstate '45000' set message_text = 'Дата окончания обучения меньше даты старта обучения';
end if;
end//

-- Проверяем триггер
INSERT INTO `users_courses` VALUES ('101','105','6','1988-11-08','1988-11-07','33');

















