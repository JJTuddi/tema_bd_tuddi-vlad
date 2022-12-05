drop schema if exists cars;
create schema cars;

use cars;

create table `cars`.`client` (
	`id` int not null auto_increment,
	`first_name` varchar(32) not null,
	`last_name` varchar(32) not null,
	`cnp` char(13) not null,
	`phone_number` char(10) not null,
	`email` varchar(64) not null,
	`address` varchar(128) not null,
primary key (`id`),
unique index `id_unique` (`id` asc) visible,
unique index `cnp_unique` (`cnp` asc) visible);


create table model(
	`id` int not null auto_increment,
	`no_of_seats` int not null,
	`engine_capacity` int not null,
	`engine_power` int not null,
	`reservoir_capacity` int not null,
	`weight` int not null,
	`color` varchar(256) not null,
    primary key (id)
);

create table `cars`.`shipment` (
  `id` int not null auto_increment,
  `scheduled_date` date not null,
  `delivery_company_code` char(5) not null,
  primary key (`id`),
  unique index `id_unique` (`id` asc) visible
);

create table car(
	`id` int not null auto_increment,
    `name` varchar(256),
	`model_id` int,
	primary key (id),
    foreign key (model_id) references model(id)
);

create table order_(
	`id` int not null auto_increment,
	`shipment_id` int,
	`client_id` int,
	`price` int,
    primary key (id),
    foreign key (shipment_id) references shipment(id),
    foreign key (client_id) references client(id)
);

create table `cars`.`order_details` (
  `id` int not null auto_increment,
  `order_id` int not null,
  `car_id` int not null,
  primary key (`id`),
  unique index `id_unique` (`id` asc) visible,
  index `order_details_car_id_fk_idx` (`car_id` asc) visible,
  index `order_details_order_id_fk_idx` (`order_id` asc) visible,
  constraint `order_details_order_id_fk`
    foreign key (`order_id`)
    references `cars`.`order_` (`id`)
    on delete cascade
    on update cascade,
  constraint `order_details_car_id_fk`
    foreign key (`car_id`)
    references `cars`.`car` (`id`)
    on delete no action
    on update no action);

create table service_schedule(
	`id` int not null auto_increment,
    `schedule_date` timestamp not null,
    `car_id` int not null,
    `client_id` int not null,
    primary key(`id`),
    foreign key (`car_id`) references car(`id`),
    foreign key (`client_id`) references client(`id`)
);

INSERT INTO `cars`.`model` 
                        (no_of_seats, engine_capacity, engine_power, reservoir_capacity, weight, color) 
                        VALUES (4, 277, 179, 5, 2000, "red"), (4, 119, 164, 10, 2000, "red"), (3, 276, 112, 6, 2000, "red"), (2, 150, 138, 5, 2000, "red"), 
                        (2, 189, 160, 10, 4000, "red"), (2, 123, 127, 9, 1000, "red"), (4, 111, 125, 3, 2000, "red"), (2, 310, 173, 9, 3000, "red"), (4, 233, 96, 8, 1000, "red"), 
                        (4, 445, 103, 8, 5000, "red"), (4, 226, 170, 2, 4000, "red"), (2, 464, 76, 9, 5000, "red"), (3, 184, 74, 6, 3000, "red"), (3, 232, 148, 3, 5000, "red"), 
                        (2, 258, 159, 7, 2000, "red"), (3, 378, 70, 1, 2000, "red"), (2, 329, 199, 10, 3000, "red"), (4, 263, 94, 10, 4000, "red"), (3, 496, 81, 5, 2000, "red"), 
                        (4, 210, 135, 4, 4000, "red");
                        
INSERT INTO `cars`.`shipment` (scheduled_date, delivery_company_code) 
						VALUES ("2022-11-25", "SAME"), ("2022-11-20", "CARG"), ("2022-11-20", "FAN"), ("2022-11-25", "FAN"), 
						("2022-11-20", "SAME"), ("2022-11-27", "CARG"), ("2022-11-27", "FAN"), ("2022-11-27", "SAME"), ("2022-11-25", "CARG"), ("2022-11-25", "CARG");

INSERT INTO `cars`.`car` (name, model_id) 
						VALUES ("Audi a69-1093", 19), ("Ford Fiesta 69PLM-636", 13), ("Ford Fiesta 69PLM-2685", 17), ("Ford Fiesta 69PLM-582", 1), ("FORD 69Pix-896", 4), 
                        ("FORD 69Pix-2721", 13), ("Audi a69-767", 13), ("FORD 69Pix-1015", 1), ("Ford Fiesta 69PLM-2418", 19), ("Audi a69-1806", 17), ("FORD 69Pix-2830", 15), 
                        ("FORD 69Pix-2072", 12), ("FORD 69Pix-1872", 6), ("Volvo 77-1794", 16), ("Audi a69-2400", 7), ("Audi a69-1910", 6), ("Volvo 77-2075", 3), 
                        ("Ford Fiesta 69PLM-2446", 14), ("Audi a69-1611", 11), ("FORD 69Pix-1595", 8), ("Volvo 77-1839", 13), ("Ford Fiesta 69PLM-1304", 14), ("Audi a69-898", 7), 
                        ("Audi a69-1157", 3), ("Audi a69-994", 8), ("FORD 69Pix-1103", 5), ("Ford Fiesta 69PLM-2102", 5), ("Ford Fiesta 69PLM-1523", 18), ("Volvo 77-1679", 4), 
                        ("Ford Fiesta 69PLM-1505", 20), ("Audi a69-2234", 1), ("FORD 69Pix-780", 17), ("Volvo 77-1654", 10), ("Ford Fiesta 69PLM-1197", 9), ("Volvo 77-958", 16), 
                        ("Volvo 77-2094", 9), ("Ford Fiesta 69PLM-672", 8), ("Volvo 77-2479", 19), ("Volvo 77-2485", 20), ("Ford Fiesta 69PLM-1557", 14);

INSERT INTO `cars`.`client` (first_name, last_name, cnp, phone_number, email, address)
						VALUES ("Alin", "Neagu", 4629388296124, "0734746579", "cevaemail2@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Raul", "Dorin", 8775879454007, "0735556576", "cevaemail@yahoo.com", "cevaadresa2@yahoo.com"), 
                        ("Raul", "Dorin", 5564142158042, "0735556576", "cevaemail2@yahoo.com", "cevaadresa2@yahoo.com"), 
                        ("Alin", "Neagu", 5219532671897, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Raul", "Pascu", 8809592731098, "0734546576", "cevaemail@yahoo.com", "cevaeadresa@yahoo.com"), 
                        ("Raul", "Dorin", 3427266458909, "0734546576", "cevaemail@yahoo.com", "cevaeadresa@yahoo.com"), 
                        ("Alin", "Ionel", 9455953960027, "0734746579", "cevaemail@yahoo.com", "cevaadresa2@yahoo.com"), 
                        ("Raul", "Pascu", 5117078104684, "0734546576", "cevaemail@yahoo.com", "cevaadresa2@yahoo.com"), 
                        ("Raul", "Dorin", 9626860577597, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Mircea", "Dorin", 5799462679390, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Alin", "Neagu", 2867695192281, "0734746579", "cevaemail2@yahoo.com", "cevaeadresa@yahoo.com"), 
                        ("Alin", "Pascu", 8512731591811, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Alin", "Neagu", 7137157961979, "0735556576", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Andrei", "Ionel", 0980531566353, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Andrei", "Pascu", 3638250185549, "0735556576", "cevaemail2@yahoo.com", "cevaadresa2@yahoo.com"), 
                        ("Raul", "Neagu", 6337612998699, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Andrei", "Dorin", 1016878510820, "0734576876", "cevaemail@yahoo.com", "cevaadresa@yahoo.com"), 
                        ("Mircea", "Neagu", 3275523155413, "0734746579", "cevaemail@yahoo.com", "cevaeadresa@yahoo.com"), 
                        ("Raul", "Dorin", 4164293462665, "0734546576", "cevaemail@yahoo.com", "cevaeadresa@yahoo.com"), 
                        ("Raul", "Pascu", 2183572632414, "0735556576", "cevaemail2@yahoo.com", "cevaadresa2@yahoo.com");
                        
INSERT INTO `cars`.`order_` (shipment_id, client_id, price)
						VALUES (9, 15, 66708), (7, 20, 88610), (6, 5, 88525), (6, 14, 61055), (1, 17, 89304), (8, 11, 93424), (7, 6, 61478), (8, 19, 52884), (3, 16, 92190), (6, 16, 94849), 
                        (3, 1, 64322), (2, 6, 99496), (3, 4, 82336), (10, 1, 87264), (1, 8, 74864), (1, 13, 96242), (1, 1, 96487), (1, 12, 73936), (3, 10, 78637), (6, 19, 56614);

INSERT INTO `cars`.`order_details` (order_id, car_id)
						VALUES (14, 5), (13, 16), (8, 4), (10, 16), (13, 19), (13, 17), (11, 12), (18, 12), (5, 2), (19, 2), (6, 16), (19, 20), 
                        (18, 16), (11, 11), (19, 4), (9, 11), (11, 6), (12, 8), (10, 2), (17, 2);
                        
INSERT INTO service_schedule (schedule_date, car_id, client_id) VALUES ("2022-11-20", 16, 16), ("2022-11-27", 10, 20), ("2022-11-27", 1, 11), 
							("2022-11-20", 1, 2), ("2022-11-20", 1, 12), ("2022-11-20", 4, 17), ("2022-11-25", 4, 16), 
							("2022-11-25", 1, 2), ("2022-11-25", 10, 4), ("2022-11-20", 16, 11);
                            
-- 1
DELIMITER //
CREATE PROCEDURE getAllProducts()
BEGIN
	SELECT * FROM `cars`.`model`; 
END//

-- 3
DELIMITER //
CREATE PROCEDURE getShipmentWithinOneOrder()
BEGIN
	SELECT id as shipment_id
		FROM cars.shipment outer_s
		WHERE (SELECT count(s.id) as 'numberOfOrders'
				FROM cars.order_ o JOIN cars.shipment s 
				ON o.shipment_id = s.id
				WHERE s.id = outer_s.id
				GROUP BY s.id) = 1;
END//

-- 5: name sensitive
DELIMITER //
CREATE PROCEDURE getShipmentsThatHaveNameLike(IN name_like VARCHAR(256))
BEGIN
	SELECT * 
		FROM cars.car c JOIN cars.model m
        ON c.model_id = m.id
        WHERE c.name LIKE name_like;
END//

-- Vlad
/*DELIMITER //
CREATE PROCEDURE CountOrdersPerShipment(OUT shipment_ids INT, OUT count_results INT)
BEGIN
	SELECT shipment_id AS shipment, COUNT(*) AS number_of_orders INTO shipment_ids, count_results
	FROM order_ 
	GROUP BY shipment_id;
END//
*/

DELIMITER //
CREATE PROCEDURE CountOrdersPerShipment()
BEGIN
	SELECT shipment_id AS shipment, COUNT(*) AS number_of_orders
	FROM order_ 
	GROUP BY shipment_id;
END//

DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN `name` varchar(256),
	IN `model_id` int
)
BEGIN
	INSERT INTO car (`name`, `model_id`)
    VALUES (`name`, `model_id`);
END//

DELIMITER //
CREATE PROCEDURE FindTodaySchedules(
)
BEGIN
	SELECT id AS schedule_id
	FROM service_schedule 
	WHERE schedule_date >= curdate();
END//