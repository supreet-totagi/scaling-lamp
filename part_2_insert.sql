INSERT INTO users VALUES('Cust_1@email.com', 'Customer 1', '2021-04-08 19:10:25', '2021-04-08 19:10:25', '2', '');
INSERT INTO users VALUES('Cust_2@email.com', 'Customer 2', '2021-04-09 10:10:25', '2021-04-09 10:10:25', '1', 'invalid email');
INSERT INTO users VALUES('Cust_3@email.com', 'Customer 3', '2021-04-10 02:10:25', '2021-04-10 02:10:25', '0', '');

INSERT INTO login_attempts VALUES(1, 'Cust_1@email.com', '2021-04-10 06:10:25', false, 'mobile');
INSERT INTO login_attempts VALUES(2, 'Cust_1@email.com', '2021-04-10 06:15:25', false, 'web');

INSERT INTO food_inventory VALUES(1, 'Chicken Rice', 5.5, 10, '2021-03-08 19:10:25', '2021-05-08 19:10:25', '2021-03-06 19:10:25', '2021-03-07 19:10:25');
INSERT INTO food_inventory VALUES(2, 'Bee Hoon', 8, 5, '2021-03-08 19:10:25', '2021-05-08 19:10:25', '2021-03-06 19:10:25', '2021-03-07 19:10:25');

INSERT INTO purchases VALUES(1, 'Cust_1@email.com', 1, 2, '2021-04-10 07:15:25', '2021-04-10 07:15:25');
INSERT INTO purchases VALUES(2, 'Cust_1@email.com', 2, 1, '2021-04-10 07:35:25', '2021-04-10 07:35:25');
