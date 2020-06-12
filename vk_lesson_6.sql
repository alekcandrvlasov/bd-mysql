use vk;

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

select from_user_id, count(*) `count` from messages where to_user_id = 2 and from_user_id in
(select initiator_user_id from friend_requests where (target_user_id = 2) and status='approved'
	union
  select target_user_id from friend_requests where (initiator_user_id = 2) and status='approved')
group by from_user_id order by `count` limit 1;

-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

select count(*) from users_likes where like_to_user_id in
(select * from
(select user_id from profiles order by TIMESTAMPDIFF(YEAR, birthday, NOW()) limit 10)
temp_tab);   -- Так обходим ошибку 1235

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

select if (
(select count(*) from users_likes where like_from_user_id in
(select * from
(select user_id from profiles where gender like ('f'))
temp_tab))
>
(select count(*) m from users_likes where like_from_user_id in
(select * from
(select user_id from profiles where gender like ('m'))
temp_tab)), 
'f',
'm'
) gender;

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- Считаем, что под активностью мы будем понимать написание сообщений и постов.

select * from users where id in
((select * from
(select from_user_id from messages group by from_user_id order by 
count(*) limit 10)
temp_tab)
	union
(select * from
(select user_id from posts group by user_id order by 
count(*) limit 10)
temp_tab)) limit 10
;






