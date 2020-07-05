CREATE DATABASE languages_courses;

USE languages_courses;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone BIGINT NOT NULL UNIQUE, 
    birthday DATE,
    language ENUM('RUSSIAN', 'ENGLISH', 'DEUTCH'),
    password VARCHAR(10),
    INDEX (email),
    INDEX (firstname, lastname)
);

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    level ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'),
    language ENUM('DEUTCH', 'ENGLISH'),
    INDEX (name, level)
);

DROP TABLE IF EXISTS users_courses;
CREATE TABLE users_courses (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
	courses_id BIGINT UNSIGNED NOT NULL,
    users_start_date DATE NOT NULL,
    users_end_date DATE,
    users_grade INT UNSIGNED,
    INDEX (user_id, courses_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (courses_id) REFERENCES courses(id)
);

DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    language ENUM('ENGLISH', 'DEUTCH'),
    date DATE NOT NULL,
    level ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'),
    genre VARCHAR(10) NOT NULL,
    accent ENUM('GB', 'USA', 'AUS'),
    body TEXT NOT NULL,
    count_words INT NOT NULL,
    INDEX (name),
    INDEX (author)
);

DROP TABLE IF EXISTS users_books;
CREATE TABLE users_books (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
	books_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (books_id) REFERENCES books(id)
);

DROP TABLE IF EXISTS video_puzzle;
CREATE TABLE video_puzzle (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    language ENUM('ENGLISH', 'DEUTCH'),
    date DATE NOT NULL,
    level ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'),
    genre VARCHAR(10) NOT NULL,
    accent ENUM('GB', 'USA', 'AUS'),
    count_words INT NOT NULL,
    subtutles TEXT NOT NULL, 
    body LONGBLOB NOT NULL,
    size INT NOT NULL,
	metadata JSON,
    media_type VARCHAR(10) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (name),
    INDEX (author)
);

DROP TABLE IF EXISTS users_video_puzzle;
CREATE TABLE users_video_puzzle (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
	video_puzzle_id BIGINT UNSIGNED NOT NULL,
    users_count_words INT NOT NULL,
    users_start_date DATE NOT NULL,
    users_end_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (video_puzzle_id) REFERENCES video_puzzle(id)
);

DROP TABLE IF EXISTS songs;
CREATE TABLE songs (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    language ENUM('ENGLISH', 'DEUTCH'),
    date DATE NOT NULL,
    level ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'),
    genre VARCHAR(10) NOT NULL,
    accent ENUM('GB', 'USA', 'AUS'),
    count_words INT NOT NULL,
    body LONGBLOB NOT NULL,
    size INT NOT NULL,
	metadata JSON,
    media_type VARCHAR(10) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (name),
    INDEX (author)
);

DROP TABLE IF EXISTS mailing_lists;
CREATE TABLE mailing_lists (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    language ENUM('ENGLISH', 'DEUTCH'),
    date DATE NOT NULL,
    categories VARCHAR(10) NOT NULL,
    INDEX (author),
    INDEX (categories)
);

DROP TABLE IF EXISTS users_mailing_lists;
CREATE TABLE users_mailing_lists (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
	mailing_lists_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (mailing_lists_id) REFERENCES mailing_lists(id)
);

DROP TABLE IF EXISTS users_songs;
CREATE TABLE users_songs (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
	songs_id BIGINT UNSIGNED NOT NULL,
    users_count_words INT NOT NULL,
    users_start_date DATE NOT NULL,
    users_end_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (songs_id) REFERENCES songs(id)
);

SET FOREIGN_KEY_CHECKS=1;









