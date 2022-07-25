--IDB ASSIGNMENT

---------------------------------Strong Entities---------------------------------
--AIRLINE_T (Row3)
CREATE TABLE AIRLINE_T
(
air_flight_num_pk CHAR(6) NOT NULL,
air_company VARCHAR(40) NOT NULL,
PRIMARY KEY (air_flight_num_pk)
)

--BOOKING_OFFICE_T (Row9)
CREATE TABLE BOOKING_OFFICE_T
(
bo_id_pk CHAR(7) NOT NULL,
bo_state VARCHAR(40) NOT NULL,
bo_street VARCHAR(60) NOT NULL,
bo_city VARCHAR(40) NOT NULL,
bo_postcode VARCHAR(10) NULL,
bo_phone_num VARCHAR(20) NOT NULL,
PRIMARY KEY (bo_id_pk)
)

--FLIGHT_T (Row19)
CREATE TABLE FLIGHT_T
(
fli_num_pk CHAR(4) NOT NULL,
fli_business_seat NUMERIC(3) NULL,
fli_economy_seat NUMERIC(3) NOT NULL,
fli_capacity NUMERIC(3) NOT NULL,
fli_departure_time TIME NOT NULL,
fli_arrival_time TIME NOT NULL,
fli_departure_date DATE NOT NULL,
fli_arrival_date DATE NOT NULL,
fli_origin VARCHAR(40) NOT NULL,
fli_destination VARCHAR(40) NOT NULL,
air_flight_num_pk CHAR(6) NOT NULL,
PRIMARY KEY (fli_num_pk),
FOREIGN KEY (air_flight_num_pk) REFERENCES AIRLINE_T(air_flight_num_pk)
)

--PILOT_T (Row35)
CREATE TABLE PILOT_T
(
pil_id_pk CHAR(7) NOT NULL,
pil_staff_fname VARCHAR(40) NOT NULL,
pil_staff_lname VARCHAR(40) NOT NULL,
pil_gender CHAR(1) NOT NULL,
pil_dob DATE NOT NULL,
pil_age NUMERIC(3) NOT NULL,
pil_experience NUMERIC(2) NOT NULL,
pil_position VARCHAR(2) NOT NULL,
pil_flying_hours NUMERIC(6) NOT NULL,
pil_salary NUMERIC(8) NOT NULL,
air_flight_num_pk CHAR(6) NOT NULL,
PRIMARY KEY (pil_id_pk),
FOREIGN KEY (air_flight_num_pk) REFERENCES AIRLINE_T(air_flight_num_pk)
)

--FLIGHT_ATTENDANT_T (Row51)
CREATE TABLE FLIGHT_ATTENDANT_T
(
fa_id_pk CHAR(5) NOT NULL,
fa_fname VARCHAR(40) NOT NULL,
fa_lname VARCHAR(40) NOT NULL,
fa_gender CHAR(1) NOT NULL,
fa_position VARCHAR(2) NOT NULL,
fa_salary NUMERIC(7) NOT NULL,
fa_phone_num VARCHAR(20) NOT NULL,
fa_street VARCHAR(40) NULL,
fa_city VARCHAR(40) NOT NULL,
fa_state VARCHAR(40) NOT NULL,
fa_postcode VARCHAR(10) NOT NULL,
fa_country VARCHAR(40) NOT NULL,
air_flight_num_pk CHAR(6) NOT NULL,
PRIMARY KEY (fa_id_pk),
FOREIGN KEY (air_flight_num_pk) REFERENCES AIRLINE_T(air_flight_num_pk)
)

--CUSTOMER_T (Row69)
CREATE TABLE CUSTOMER_T
(
cust_id_pk CHAR(14) NOT NULL,
cust_fname VARCHAR(40) NOT NULL,
cust_lname VARCHAR(40) NOT NULL,
cust_street VARCHAR(40) NULL,
cust_city VARCHAR(40) NOT NULL,
cust_state VARCHAR(40) NOT NULL,
cust_postcode VARCHAR(10) NULL,
cust_country VARCHAR(40) NOT NULL,
cust_gender CHAR(1) NOT NULL,
PRIMARY KEY (cust_id_pk)
)

---------------------------------Weak Entities---------------------------------
--CUST_EMAIL_T (Row83)
CREATE TABLE CUST_EMAIL_T
(
cust_id_pk CHAR(14) NOT NULL,
ce_id_pk INT NOT NULL,
ce_email_address VARCHAR(40) NOT NULL,
PRIMARY KEY (cust_id_pk, ce_id_pk),
FOREIGN KEY (cust_id_pk) REFERENCES CUSTOMER_T(cust_id_pk)			
)

--CUST_HPHONE_NUMBER_T(Row91)
CREATE TABLE CUST_HPHONE_NUMBER_T
(
cust_id_pk CHAR(14) NOT NULL,
ch_id_pk INT NOT NULL,
ch_hphone_num VARCHAR(20) NOT NULL,
PRIMARY KEY (cust_id_pk, ch_id_pk),
FOREIGN KEY (cust_id_pk) REFERENCES CUSTOMER_T(cust_id_pk)			
)

--FLIGHT_BOOKING_T(Row99)
CREATE TABLE FLIGHT_BOOKING_T
(
fb_book_num_pk CHAR(10) NOT NULL,
cust_id_pk CHAR(14) NOT NULL,
fli_num_pk CHAR(4) NOT NULL,
bo_id_pk CHAR(7) NOT NULL,
fb_book_date DATE NOT NULL,
fb_class CHAR(1) NOT NULL,
fb_price NUMERIC(5) NOT NULL,
fb_status CHAR(1) NOT NULL,
fb_paid_amount NUMERIC(5) NULL,
fb_outstanding NUMERIC(5) NULL,
PRIMARY KEY (fb_book_num_pk, cust_id_pk, fli_num_pk, bo_id_pk),
FOREIGN KEY (cust_id_pk) REFERENCES CUSTOMER_T(cust_id_pk),
FOREIGN KEY (fli_num_pk) REFERENCES FLIGHT_T(fli_num_pk),
FOREIGN KEY (bo_id_pk) REFERENCES BOOKING_OFFICE_T(bo_id_pk)
)

--ATTENDANT_SCHEDULE_T (Row114)
CREATE TABLE ATTENDANT_SCHEDULE_T
(
fa_id_pk CHAR(5) NOT NULL,
fli_num_pk CHAR(4) NOT NULL,
PRIMARY KEY (fa_id_pk, fli_num_pk),
FOREIGN KEY (fa_id_pk) REFERENCES FLIGHT_ATTENDANT_T (fa_id_pk),
FOREIGN KEY (fli_num_pk) REFERENCES FLIGHT_T (fli_num_pk)
)

--PILOT_SCHEDULE_T (Row131)
CREATE TABLE PILOT_SCHEDULE_T
(
pil_id_pk CHAR(7) NOT NULL,
fli_num_pk  CHAR(4) NOT NULL,
PRIMARY KEY (pil_id_pk, fli_num_pk),
FOREIGN KEY (pil_id_pk) REFERENCES PILOT_T (pil_id_pk),
FOREIGN KEY (fli_num_pk) REFERENCES FLIGHT_T (fli_num_pk)
)

--CUST_BOOKING_PLACE_T(Row128)
CREATE TABLE CUST_BOOKING_PLACE_T
(
cust_id_pk CHAR(14) NOT NULL,
bo_id_pk CHAR(7) NOT NULL,
PRIMARY KEY (cust_id_pk, bo_id_pk),
FOREIGN KEY (cust_id_pk) REFERENCES CUSTOMER_T(cust_id_pk),
FOREIGN KEY (bo_id_pk) REFERENCES BOOKING_OFFICE_T(bo_id_pk)
)


----AIRLINE_ROUTE_T (Row114)
--CREATE TABLE AIRLINE_ROUTE_T
--(
--ar_origin CHAR(6) NOT NULL,
--ar_destination CHAR(6) NOT NULL,
--fli_num_pk CHAR(4) NOT NULL,
--PRIMARY KEY (ar_origin, ar_destination, fli_num_pk),
--FOREIGN KEY (ar_origin) REFERENCES STATE_T (stat_id_pk),
--FOREIGN KEY (ar_destination) REFERENCES STATE_T(stat_id_pk),
--FOREIGN KEY (fli_num_pk) REFERENCES FLIGHT_T(fli_num_pk)
--)

----STATE_T (Row9)
--CREATE TABLE STATE_T
--(
--stat_id_pk CHAR(6) NOT NULL,
--stat_name VARCHAR(40) NOT NULL,
--PRIMARY KEY (stat_id_pk)
--)

--3.1.1 SQL DDL commands to insert tuples into AIRLINE_T
INSERT INTO AIRLINE_T
(
air_flight_num_pk,
air_company)
VALUES　('AA1100','Alpha Airways'),
        ('BA1201','Beta Airline'),
        ('CA1351','Charlie Airways'),
		('CA8760','Core Airways'),
        ('PA2098','Peak Airways'),
        ('DA1442','Delta Airways'),
        ('EA1709','Echo Airline'),
        ('FA1666','Foxtrot Airline'),
        ('GA1771','Garuda Airline'),
        ('SA1865','Spark Airline')

--3.1.2 SQL DML commands to insert tuples into BOOKING_OFFICE_T
INSERT INTO BOOKING_OFFICE_T
(
bo_id_pk,
bo_state,
bo_street,
bo_city,
bo_postcode,
bo_phone_num)
VALUES ('KDH6969','Kedah','14, Lorong Air Masin','Kuala Kedah','35000','08461345144'),
       ('KLT0590','Kelantan','69, Jalan Dusun Raja','Kota Bhuru','46000','08124657981'),
       ('NSN6969','Negeri Sembilan','8, Millennia Business Centre Jin Tan Sri Manickavasagam','Seremban','70200','0626989333'),
       ('PHG7070','Pahang','B230,1St Floor Jīn Air Putih','Kuantan','25300','052681214'),
       ('PKL7373','Wilayah Perseku','12, Lorong Medan Tuanku Satu','Kuala Lumpur','50300','0362033984'),
       ('PNG1340','Pulau Pinang','11, Lbh Muntri','Georgetown','10200','082111110808'),
       ('PRK6868','Perak','143, Leboh Perajurit 3 Garden East','Ipoh','31400','0556375098'),
       ('SBH7171','Sabah','1, Wisma New Far East Taman Far East','Kota Kinabalu','88300','052822931149'),
       ('SRW7272','Sarawak','1,Jalan Padungan Utara','Kuching','93100','0622247778'),
       ('TRG3210','Terengganu','14, Jalan Sultan Ismail','Kuala Terengganu','14500','08216549211')
--3.1.3 SQL DML commands to insert tuples into FLIGHT_T
INSERT INTO FLIGHT_T
(
fli_num_pk,
fli_business_seat,
fli_economy_seat,
fli_capacity,
fli_departure_time,
fli_arrival_time,
fli_departure_date,
fli_arrival_date,
fli_origin,
fli_destination,
air_flight_num_pk)
VALUES ('1023',38,250,250,'10:45:00','11:20:00','2021-06-19','2021-06-19','Kuala Lumpur','Sarawak','EA1709'),
       ('1134',20,160,180,'12:55:00','14:00:00','2021-06-28','2021-06-28','Kuala Lumpur','Sabah','SA1865'),
       ('1214',26,196,222,'20:45:00','22:45:00','2021-07-30','2021-07-30','Kuala Lumpur','Pahang','DA1442'),
       ('1242',31,217,248,'16:30:00','17:30:00','2021-06-12','2021-06-12','Sabah','Kuala Lumpur','BA1201'),
       ('1256',16,170,186,'18:50:00','19:30:00','2021-07-10','2021-07-10','Kuala Lumpur','Negeri Sembilan','CA8760'),
       ('1324',15,180,195,'17:30:00','18:30:00','2021-05-22','2021-05-22','Sarawak','Kuala Lumpur','AA1100'),
       ('1432',16,160,176,'22:00:00','23:45:00','2021-08-09','2021-08-09','Perak','Kuala Lumpur','FA1666'),
       ('1454',34,212,246,'14:30:00','16:30:00','2021-06-30','2021-06-30','Negeri Sembilan','Perak','PA2098'),
       ('1953',14,179,193,'17:30:00','19:30:00','2021-05-27','2021-05-27','Negeri Sembilan','Sabah','GA1771'),
	   ('2157',24,198,222,'17:00:00','18:45:00','2021-05-24','2021-05-24','Pahang','Kuala Lumpur','CA1351')
--3.1.4 SQL DML commands to insert tuples into PILOT_T
INSERT INTO PILOT_T
(
pil_id_pk,
pil_staff_fname,
pil_staff_lname,
pil_gender,
pil_dob,
pil_age,
pil_experience,
pil_position,
pil_flying_hours,
pil_salary,
air_flight_num_pk)
VALUES ('01-6969','Macel','Gunga','M','1981-10-13',39,17,'C',16312,18000,'AA1100'),
       ('02-7777','Vinke','Thewma','M','1975-04-02',46,46,'CC',8012,10900,'BA1201'),
       ('05-4057','Bernard','Wilson','M','1977-01-01',44,19,'C',20970,20500,'SA1865'),
       ('07-0870','Dan','Johnson','M','1984-08-05',36,17,'CC',15968,14000,'CA8760'),
       ('10-3765','Alice','Smith','F','1995-07-27',25,4,'CC',2021,4600,'EA1709'),
       ('11-1019','Charlie','Miller','M','1966-04-08',55,30,'C',25789,25000,'PA2098'),
       ('12-4231','Mikael','Tinnason','M','1980-08-17',40,18,'C',9901,10000,'CA1351'),
       ('21-6924','Yanri','Tinmar','F','1978-07-30',43,20,'CC',3502,5600,'GA1771'),
       ('23-6523','Nipip','Wayanseti','M','1991-03-22',30,10,'C',14023,13900,'FA1666'),
	   ('51-3241','Vansei','Colasni','F','1989-12-13',31,11,'C',10231,12000,'DA1442')
--3.1.5 SQL DML commands to insert tuples into FLIGHT_ATTENDANT_T
INSERT INTO FLIGHT_ATTENDANT_T
(
fa_id_pk,
fa_fname,
fa_lname,
fa_gender,
fa_position,
fa_salary,
fa_phone_num,
fa_street,
fa_city,
fa_state,
fa_postcode,
fa_country,
air_flight_num_pk)
VALUES ('0-564','Ann','Ross','F','CP',8000,'6026933777','Jalan Tanjung Chat 4','Kota Bharu','Kelantan','15400','Malaysia','SA1865'),
       ('0-565','John','Taylor','M','FP',3500,'6521245618','678A Jurong West Street 64','Singapore','Singapore','641678','Singapore','CA8760'),
       ('1-235','Catherine','Smith','F','FA',2800,'6024154233','Jalan  Teknologi 5','Kuala Lumpur','Wilayah Persekutuan Kuala Lumpur','57000','Malaysia','EA1709'),
       ('1-333','Mike','Hunt','M','FA',3000,'6223897534','Jalan Benteng Jaya 16','Kota Tangerang','Banten','15111','Indonesia','PA2098'),
       ('2-252','Rihen','Kelmai','M','FA',3200,'62965748351','Jalan Soekarno Hatta 61','Kota Balikpapan','East Kalimantan','76214','Indonesia','DA1442'),
       ('4-562','Kelmic','Kom','M','SP',6900,'6598217168','Jalan Setiabudhi 8','Kota Bandung','Jawa Barat','40141','Indonesia','BA1201'),
       ('6-693','Terpe','Yenbri','M','FP',5000,'65789451345','Jalan Bung Tomo 4','Kota Surabaya','East Java','60245','Indonesia','FA1666'),
       ('6-969','Ranzah','Nihaf','F','FA',2800,'62212691611','Jalan Shonda Makurmpad','Kota Malang','East Java','65113','Indonesia','GA1771'),
       ('9-325','Vinke','Wansei','F','CP',8100,'6519452014','Jalan Dermaga 69','Kota Samarinda','East Kalimantan','75242','Indonesia','AA1100'),
	   ('9-936','Nathanyo','Cenvi','F','FA',3000,'62821450142','Grusiva Niyamasubar St','City of Seria','Belait','2733','Brunei','CA1351')                 
--3.1.6 SQL DML commands to insert tuples into CUSTOMER_T
INSERT INTO CUSTOMER_T
(
cust_id_pk,
cust_fname,
cust_lname,
cust_street,
cust_city,
cust_state,
cust_postcode,
cust_country,
cust_gender)
VALUES ('123400-56-9876','Ching','Chong','Jiu Wei Cun 81 Hao','Sha Tian','Guang Dong','523000','China','F'),
       ('164973-59-1576','Usman','Mailis','No.10 Kampung','Bota','Perak','32600','Malaysia','M'),
       ('550106-12-5821','Dig','Beck','Seksyen Bb 11, Bukit Beruntung','Rawang','Selangor','48300','Malaysia','M'),
       ('581235-61-2456','Dhason','Padnakunar','Lot 3706 Jin Tengah','Bandar Seri Begawan','Brunei and Muara','8411','Brunei','M'),
       ('610522-10-5378','Ligma','Bllas','No.12 Jalan Bersatu (13/4)','Petaling Jaya','Selangor','46200','Brunei','F'),
       ('615493-59-7984','Sivaguru','Kael','No.3 Jln Sek Keb','Bukit Payong','Terengganu','21400','Malaysia','M'),
       ('923497-36-5951','Tanvir','Subarnamiyn','20-1 A Jln Pjs 3/36 Taman Sri Manja','Petaling Jaya','Selangor','58200','Malaysia','M'),
       ('930906-14-7043','Ben','Dover','No.8 Jin Air Panas','Kuala Lumpur','Wilayah Persekutuan Kuala Lumpur','53200','Malaysia','M'),
       ('941130-07-5153','Icewallow','Kam','Jalan Setiabudi 10','Malang','Jawa Timur','65111','Indonesia','F'),
	   ('985632-41-6932','Chad','Upin','66A Jln Tabuan','Kuching','Sarawak','93100','Malaysia','M'),
	   ('691234-43-7872','Ahmad','Qafi','13 Jalan Payah, Kampung Aik Hwa,','Muar','Johor','84200','Malaysia','M'),
	   ('771203-90-9922','Rosa','Fatima', '13 Jalan Payah, Kampung Aik Hwa,','Muar','Johor','84200','Malaysia','F')

--3.1.7 SQL DML commands to insert tuples into CUST_EMAIL_T
INSERT INTO CUST_EMAIL_T
(
cust_id_pk,
ce_id_pk,
ce_email_address)
VALUES ('550106-12-5821',1,'digbeck@hotmail.com'),
       ('930906-14-7043',2,'bendover69@yahoo.com'),
       ('941130-07-5153',3,'wallowicekam123@gmail.com'),
       ('610522-10-5378',4,'ligmaballs@hotmail.com'),
       ('123400-56-9876',5,'chingchongchang@yahoo.com'),
       ('581235-61-2456',6,'dhason@apu.edu.my'),
       ('615493-59-7984',7,'tanvir@apu.edu.my'),
       ('923497-36-5951',8,'sivaguru123@yahoo.com'),
       ('164973-59-1576',9,'usmanthegreat@yahoo.com'),
	   ('985632-41-6932',10,'xXDemoLordXx@yahoo.com')

--3.1.8 SQL DML commands to insert tuples into CUST_HPHONE_NUMBER_T
INSERT INTO CUST_HPHONE_NUMBER_T
(
cust_id_pk,
ch_id_pk,
ch_hphone_num)
VALUES ('550106-12-5821',1,'6084901516'),
       ('930906-14-7043',2,'60249241562'),
       ('941130-07-5153',3,'62498456852'),
       ('610522-10-5378',4,'67180200120'),
       ('123400-56-9876',5,'8156562001'),
       ('581235-61-2456',6,'67199998877'),
       ('615493-59-7984',7,'60164624389'),
       ('923497-36-5951',8,'608214944201'),
       ('164973-59-1576',9,'60121249895'),
	   ('985632-41-6932',10,'60333321644')
--3.1.9 SQL DML commands to insert tuples into FLIGHT_BOOKING_T
INSERT INTO FLIGHT_BOOKING_T
(
fb_book_num_pk,
fli_num_pk,
cust_id_pk,
bo_id_pk,
fb_book_date,
fb_class,
fb_price,
fb_status,
fb_paid_amount,
fb_outstanding)
VALUES ('0456327110','1023','550106-12-5821','PKL7373','2021-04-17','B',600,'S',100,400),
       ('6902341890','1134','930906-14-7043','PKL7373','2020-08-09','E',220,'B',200,20),
       ('9736440028','1454','941130-07-5153','NSN6969','2020-08-16','E',230,'C', NULL, NULL),
       ('8969912362','1256','610522-10-5378','PKL7373','2020-12-21','E',170,'B',170, NULL),
       ('6124953478','1324','123400-56-9876','SBH7171','2020-12-14','B',1000,'B',900,100),
       ('8453125549','1242','581235-61-2456','SRW7272','2021-02-06','B',575,'B',550,25),
       ('1324875613','1432','615493-59-7984','PHG7070','2021-01-09','E',235,'C', NULL, NULL),
       ('4950351204','2157','923497-36-5951','PKL7373','2021-04-12','E',220,'S', NULL, NULL),
       ('0326592175','1953','164973-59-1576','PRK6868','2020-10-13','E',215,'S', NULL, NULL),
	   ('1203562047','1214','985632-41-6932','NSN6969','2020-12-19','B',240,'C', NULL, NULL)

--3.1.10 SQL DML commands to insert tuples into ATTENDANT_SCHEDULE_T
INSERT INTO ATTENDANT_SCHEDULE_T
(
fa_id_pk,
fli_num_pk)
VALUES ('1-235','1023'),
       ('0-564','1134'),
       ('1-333','1454'),
       ('0-564','1256'),
       ('9-325','1324'),
       ('4-562','1242'),
       ('9-936','2157'),
       ('2-252','1214'),
       ('6-693','1432'),
	   ('6-969','1953')

--3.1.11 SQL DML commands to insert tuples into PILOT_SCHEDULE_T
INSERT INTO PILOT_SCHEDULE_T
(
pil_id_pk,
fli_num_pk)
VALUES ('10-3765','1023'),
       ('05-4057','1134'),
       ('11-1019','1454'),
       ('07-0870','1256'),
       ('01-6969','1324'),
       ('02-7777','1242'),
       ('12-4231','2157'),
       ('51-3241','1214'),
       ('23-6523','1432'),
       ('21-6924','1953')

--3.1.12 SQL DML commands to insert tuples into CUST_BOOKING_PLACE_T
INSERT INTO CUST_BOOKING_PLACE_T
(
cust_id_pk,
bo_id_pk)
VALUES ('550106-12-5821','PKL7373'),
       ('930906-14-7043','PKL7373'),
       ('941130-07-5153','NSN6969'),
       ('610522-10-5378','PKL7373'),
       ('123400-56-9876','SBH7171'),
       ('581235-61-2456','SRW7272'),
       ('615493-59-7984','PHG7070'),
       ('923497-36-5951','PKL7373'),
       ('164973-59-1576','PRK6868'),
	   ('985632-41-6932','NSN6969')

----OLD VERSION
----3.1.1 SQL DDL commands to insert tuples into AIRLINE_T
--INSERT INTO AIRLINE_T
--(
--air_flight_num_pk,
--air_company)
--VALUES　('AA1100','Alpha Airways'),
--        ('BA1201','Beta Airline'),
--		('CA1351','Charlie Airways'),
--        ('CA8760','Core Airways'),
--        ('PA2098','Peak Airways'),
--        ('DA1442','Delta Airways'),
--        ('EA1709','Echo Airline'),
--        ('FA1666','Foxtrot Airline'),
--        ('GA1771','Garuda Airline'),
--        ('SA1865','Spark Airline')

----3.1.2 SQL DML commands to insert tuples into BOOKING_OFFICE_T
--INSERT INTO BOOKING_OFFICE_T
--(
--bo_id_pk,
--bo_state,
--bo_street,
--bo_city,
--bo_postcode,
--bo_phone_num)
--VALUES ('KDH6969','Kedah','14, Lorong Air Masin','Kuala Kedah','35000','08461345144'),
--       ('KLT059','Kelantan','69, Jalan Dusun Raja','Kota Bhuru','46000','08124657981'),
--       ('NSN6969','Negeri Sembilan','8, Millennia Business Centre Jin Tan Sri Manickavasagam','Seremban','70200','0626989333'),
--       ('PHG7070','Pahang','B230,1St Floor Jīn Air Putih','Kuantan','25300','052681214'),
--       ('PKL7373','Wilayah Perseku','12, Lorong Medan Tuanku Satu','Kuala Lumpur','50300','0362033984'),
--       ('PNG134','Pulau Pinang','11, Lbh Muntri','Georgetown','10200','082111110808'),
--       ('PRK6868','Perak','143, Leboh Perajurit 3 Garden East','Ipoh','31400','0556375098'),
--       ('SBH7171','Sabah','1, Wisma New Far East Taman Far East','Kota Kinabalu','88300','052822931149'),
--       ('SRW7272','Sarawak','1,Jalan Padungan Utara','Kuching','93100','0622247778'),
--       ('TRG321','Terengganu','14, Jalan Sultan Ismail','Kuala Terengganu','14500','08216549211')

----3.1.3 SQL DML commands to insert tuples into FLIGHT_T
--INSERT INTO FLIGHT_T
--(
--fli_num_pk,
--fli_business_seat,
--fli_economy_seat,
--fli_capacity,
--fli_departure_time,
--fli_arrival_time,
--fli_departure_date,
--fli_arrival_date,
--fli_origin,
--fli_destination,
--air_flight_num_pk)
--VALUES ('1023',38,250,250,'10:45:00','11:20:00','2021-06-19','2021-06-19','Kuala Lumpur','Sarawak','EA1709'),
--       ('1134',20,160,180,'12:55:00','14:00:00','2021-06-28','2021-06-28','Kuala Lumpur','Sabah','SA1865'),
--       ('1214',26,196,222,'20:45:00','22:45:00','2021-07-30','2021-07-30','Kuala Lumpur','Pahang','DA1442'),
--       ('1242',31,217,248,'16:30:00','17:30:00','2021-06-12','2021-06-12','Sabah','Kuala Lumpur','BA1201'),
--       ('1256',16,170,186,'18:50:00','19:30:00','2021-07-10','2021-07-10','Kuala Lumpur','Negeri Sembilan','CA8760'),
--       ('1324',15,180,195,'17:30:00','18:30:00','2021-05-22','2021-05-22','Sarawak','Kuala Lumpur','AA1100'),
--       ('1432',16,160,176,'22:00:00','23:45:00','2021-08-09','2021-08-09','Perak','Kuala Lumpur','FA1666'),
--       ('1454',34,212,246,'14:30:00','16:30:00','2021-06-30','2021-06-30','Negeri Sembilan','Perak','PA2098'),
--       ('1953',14,179,193,'17:30:00','19:30:00','2021-05-27','2021-05-27','Negeri Sembilan','Sabah','GA1771'),
--       ('2157',24,198,222,'17:00:00','18:45:00','2021-05-24','2021-05-24','Pahang','Pahang','CA8760')
	   
----3.1.4 SQL DML commands to insert tuples into PILOT_T
--INSERT INTO PILOT_T
--(
--pil_id_pk,
--pil_staff_fname,
--pil_staff_lname,
--pil_gender,
--pil_dob,
--pil_age,
--pil_experience,
--pil_position,
--pil_flying_hours,
--pil_salary,
--air_flight_num_pk)
--VALUES ('01-6969','Macel','Gunga','M','1981-10-13',39,17,'C',16312,900000,'AA1100'),
--       ('02-7777','Vinke','Thewma','M','1975-04-02',46,46,'CC',8012,350000,'BA1201'),
--       ('05-4057','Bernard','Wilson','M','1977-01-01',44,19,'C',16810,900000,'SA1865'),
--       ('07-0870','Dan','Johnson','M','1984-08-05',36,17,'CC',15968,400000,'CA8760'),
--       ('10-3765','Alice','Smith','F','1995-07-27',25,4,'CC',2021,250000,'EA1709'),
--       ('11-1019','Chrlie','Miller','M','1966-04-08',55,30,'C',25789,1200000,'PA2098'),
--       ('12-4231','Sukimi','Shidani','F','1980-08-17',40,18,'CC',9901,375000,'CA8760'),
--       ('21-6924','Yanri','Yanri','M','1978-07-30',43,20,'CC',3502,275000,'GA1771'),
--       ('23-6523','Nipip','Wayanseti','M','1991-03-22',30,10,'C',14023,800000,'FA1666'),
--       ('51-3241','Vansei','Colasni','F','1989-12-13',31,11,'C',10231,760000,'DA1442')

----3.1.5 SQL DML commands to insert tuples into FLIGHT_ATTENDANT_T
--INSERT INTO FLIGHT_ATTENDANT_T
--(
--fa_id_pk,
--fa_fname,
--fa_lname,
--fa_gender,
--fa_position,
--fa_salary,
--fa_phone_num,
--fa_street,
--fa_city,
--fa_state,
--fa_postcode,
--fa_country,
--air_flight_num_pk)
--VALUES ('0-564','Ann','Ross','F','CP',250000,'6026933777','Jalan Tanjung Chat 4','Kota Bharu','Kelantan','15400','Malaysia','SA1865'),
--       ('0-565','John','Taylor','M','FP',200000,'6521245618','678A Jurong West Street 64','Singapore','Singapore','641678','Singapore','CA8760'),
--       ('1-235','Catherine','Smith','F','FA',1000000,'6024154233','Jalan  Teknologi 5','Kuala Lumpur','Wilayah Persekutuan Kuala Lumpur','57000','Malaysia','EA1709'),
--       ('1-333','Mike','Hunt','M','FA',150000,'6223897534','Jalan Benteng Jaya 16','Kota tangerang','Banten','15111','Indonesia','PA2098'),
--       ('2-252','Rihen','Kelmai','M','FA',125000,'62965748351','Jalan Soekarno Hatta 61','Kota Balikpapan','East Kalimantan','76214','Indonesia','DA1442'),
--       ('4-562','Kelmic','Kom','M','SP',225000,'6598217168','Jalan Setiabudhi 8','Kota Bandung','Jawa Barat','40141','Indonesia','BA1201'),
--       ('6-693','Terpe','Yenbri','M','FP',190000,'65789451345','Jalan Bung Tomo 4','Kota Surabaya','East Java','60245','Indonesia','FA1666'),
--       ('6-969','Ranzah','Nihaf','F','FA',100000,'62212691611','Jalan Shonda Makurmpad','Kota Malang','East Java','65113','Indonesia','GA1771'),
--       ('9-325','Vinke','Wansei','F','CP',250000,'6519452014','Jalan Dermaga 69','Kota Samarinda','East Kalimantan','75242','Indonesia','AA1100'),
--       ('9-936','Nathanyo','Cenvi','F','FA',150000,'62821450142','Grusiva Niyamasubar St','City of Seria','Belait','2733','Brunei','CA8760')
                 
----3.1.6 SQL DML commands to insert tuples into CUSTOMER_T
--INSERT INTO CUSTOMER_T
--(
--cust_id_pk,
--cust_fname,
--cust_lname,
--cust_street,
--cust_city,
--cust_state,
--cust_postcode,
--cust_country,
--cust_gender)
--VALUES ('123400-56-9876','Ching','Chong','Jiu Wei Cun 81 Hao','Sha Tian','Guang Dong','523000','China','F'),
--       ('164973-59-1576','Usman','Mailis','No.10 Kampung','Bota ','Perak','32600','Malaysia','M'),
--       ('550106-12-5821','Dig','Beck','Seksyen Bb 11, Bukit Beruntung','Rawang','Selangor','48300','Malaysia','M'),
--       ('581235-61-2456','Dhason','Padnakunar','Lot 3706 Jin Tengah','Bandar Seri Begawan','Brunei and Muara','8411','Brunei','M'),
--       ('610522-10-5378','Ligma','Bllas','No.12 Jalan Bersatu (13/4)','Petaling Jaya','Selangor','462000','Brunei','F'),
--       ('615493-59-7984','Sivaguru','Kael','No.3 Jin Sek Keb','Bukit Payong','Terengganu','21400','Mlaysia','M'),
--       ('923497-36-5951','Tanvir','Subarnamiyn','20-1 A Jln Pjs 3/36 Taman Sri Manja','Petaling Jaya','Selangor','58200','Malaysia','M'),
--       ('930906-14-7043','Ben','Dover','No.8 Jin Air Panas','Kuala Lumpur','Wilayah Persekutuan Kuala Lumpur','53200','Malaysia','M'),
--       ('941130-07-5153','Icewallow','Kam','Jalan Setiabudi 10','Malang','Jawa Timur','65111','Indonesia','F'),
--       ('985632-41-6932','Upin','Ipin','11-33 Jalan Ibrahim','Batu Pahat','Johor','83000','Malaysia','M')

----3.1.7 SQL DML commands to insert tuples into CUST_EMAIL_T
--INSERT INTO CUST_EMAIL_T
--(
--cust_id_pk,
--ce_id_pk,
--ce_email_address)
--VALUES ('550106-12-5821',1,'digbeck@hotmail.com'),
--       ('930906-14-7043',2,'bendover69@yahoo.com'),
--       ('941130-07-5153',3,'wallowicekam123@gmail.com'),
--       ('610522-10-5378',4,'ligmaballs@hotmail.com'),
--       ('123400-56-9876',5,'chingchongchang@yahoo.com'),
--       ('581235-61-2456',6,'dhason@apu.edu.my'),
--       ('615493-59-7984',7,'tanvir@apu.edu.my'),
--       ('923497-36-5951',8,'sivaguru123@yahoo.com'),
--       ('164973-59-1576',9,'usmanthegreat@yahoo.com'),
--       ('985632-41-6932',10,'xXDemoLordXx@yahoo.com')


----3.1.8 SQL DML commands to insert tuples into CUST_HPHONE_NUMBER_T
--INSERT INTO CUST_HPHONE_NUMBER_T
--(
--cust_id_pk,
--ch_id_pk,
--ch_hphone_num)
--VALUES ('550106-12-5821',1,'6084901516'),
--       ('930906-14-7043',2,'60249241562'),
--       ('941130-07-5153',3,'62498456852'),
--       ('610522-10-5378',4,'67180200120'),
--       ('123400-56-9876',5,'8156562001'),
--       ('581235-61-2456',6,'67199998877'),
--       ('615493-59-7984',7,'60164624389'),
--       ('923497-36-5951',8,'608214944201'),
--       ('164973-59-1576',9,'60121249895'),
--       ('985632-41-6932',10,'60333321644')

----3.1.9 SQL DML commands to insert tuples into FLIGHT_BOOKING_T
--INSERT INTO FLIGHT_BOOKING_T
--(
--fb_book_num_pk,
--fli_num_pk,
--cust_id_pk,
--bo_id_pk,
--fb_book_date,
--fb_class,
--fb_price,
--fb_status,
--fb_paid_amount,
--fb_outstanding)
--VALUES ('0456327110','1023','550106-12-5821','PKL7373','2021-04-17','B',600,'S',100,400),
--       ('6902341890','1134','930906-14-7043','PKL7373','2020-08-09','E',220,'B',200,20),
--       ('9736440028','1454','941130-07-5153','NSN6969','2020-08-16','E',230,'C', NULL, NULL),
--       ('8969912362','1256','610522-10-5378','PKL7373','2020-12-21','E',170,'B',170, NULL),
--       ('6124953478','1324','123400-56-9876','SBH7171','2020-12-14','A',1000,'B',900,100),
--       ('8453125549','1242','581235-61-2456','SRW7272','2021-02-06','B',575,'B',550,25),
--       ('1324875613','1432','615493-59-7984','PHG7070','2021-01-09','E',235,'C', NULL, NULL),
--       ('4950351204','2157','923497-36-5951','PKL7373','2021-04-12','E',220,'S', NULL, NULL),
--       ('0326592175','1953','164973-59-1576','PRK6868','2020-10-13','E',215,'S', NULL, NULL),
--       ('1203562047','1214','985632-41-6932','NSN6969','2020-12-19','B',240,'C', NULL, NULL)

----3.1.10 SQL DML commands to insert tuples into ATTENDANT_SCHEDULE_T
--INSERT INTO ATTENDANT_SCHEDULE_T
--(
--fa_id_pk,
--fli_num_pk)
--VALUES ('1-235','1023'),
--       ('0-564','1134'),
--       ('1-333','1454'),
--       ('0-565','1256'),
--       ('9-325','1324'),
--       ('4-562','1242'),
--       ('9-936','2157'),
--       ('2-252','1214'),
--       ('6-693','1432'),
--       ('6-969','1953')


----3.1.11 SQL DML commands to insert tuples into PILOT_SCHEDULE_T
--INSERT INTO PILOT_SCHEDULE_T
--(
--pil_id_pk,
--fli_num_pk)
--VALUES ('10-3765','1023'),
--       ('05-4057','1134'),
--       ('11-1019','1454'),
--       ('07-0870','1256'),
--       ('01-6969','1324'),
--       ('02-7777','1242'),
--       ('12-4231','2157'),
--       ('51-3241','1214'),
--       ('23-6523','1432'),
--       ('21-6924','1953')

----3.1.12 SQL DML commands to insert tuples into CUST_BOOKING_PLACE_T
--INSERT INTO CUST_BOOKING_PLACE_T
--(
--cust_id_pk,
--bo_id_pk)
--VALUES ('550106-12-5821','PKL7373'),
--       ('930906-14-7043','PKL7373'),
--       ('941130-07-5153','NSN6969'),
--       ('610522-10-5378','PKL7373'),
--       ('123400-56-9876','SBH7171'),
--       ('581235-61-2456','SRW7272'),
--       ('615493-59-7984','PHG7070'),
--       ('923497-36-5951','PKL7373'),
--       ('164973-59-1576','PRK6868'),
--       ('985632-41-6932','NSN6969')