use vk;

select * from users;

insert users (`firstname`, `lastname`, `email`, `phone`) values 
('Alex', 'Lexx', '128@mail.ru', '908'),
('Alexandr', 'Ivanov', '129@mail.ru', '909'),
('Alex', 'Lexx', '126@mail.ru', '908'),
('Alexandr', 'Ivanov', '127@mail.ru', '909')
;

select * from users
where firstname = 'Alex'
;

select * from users
limit 3,5
;

update users
set
	phone = '98754321'
where 
	firstname = 'Lydia' and lastname = 'Brown'
;    

select * from posts;    

insert posts (`user_id`, `body`) values 
('101', 'OkOkOkOkOkOkOkOkOkOkOkOkOkOkOkOkOkOkOkOk'),
('104', 'YesYesYesYesYesYesYesYesYesYesYesYesYesYes'),
('105', 'I love my family'),
('106', 'I miss you')
;    

select * from posts
where user_id in (10,15);

select * from posts
where user_id = 104;

delete from posts
where user_id = 104;

select * from likes;

truncate likes;

insert likes (`user_id`, `media_id`) values 
('101', '56'),
('104', '45'),
('80', '34'),
('56', '33');

