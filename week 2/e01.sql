/*
E01 - Getting Started
*/


CREATE DATABASE demo;
GO

USE demo;
GO

CREATE TABLE users (
    user_id int PRIMARY KEY IDENTITY,
    user_first_name VARCHAR(30) NOT NULL,
    user_last_name VARCHAR(30) NOT NULL,
    user_email_id VARCHAR(50) NOT NULL,
    user_email_validated bit DEFAULT 0,
    user_password VARCHAR(200),
    user_role VARCHAR(30) NOT NULL DEFAULT 'U',
    is_active bit DEFAULT 0,
    created_dt DATETIME DEFAULT getdate()
);
