Create database [GAS_BOOKING_SYSTEM]
Go
USE  [GAS_BOOKING_SYSTEM]
Go
Create schema [GBS] authorization [public]
Go

CREATE TABLE  ADMIN  (
  aid int NOT NULL,
  Pwd varchar(16) NOT NULL
  constraint Admin_pk primary key(aid)
) ;

CREATE TABLE CONSUMER_DETAIL (
  cid int  NOT NULL CHECK (cid like replicate('[0-9]',5)),
  did int NOT NULL  default 1 CHECK (did like replicate('[0-9]',1)),
  pwd varchar(16) DEFAULT NULL,
  name varchar(30) NOT NULL,
  door_number varchar(100) NOT NULL,
  city varchar(10) NOT NULL,
  pin int NOT NULL,
  m_no bigint NOT NULL,
  e_id varchar(30) NOT NULL,
  reg_date date DEFAULT NULL,
  status varchar(15) NOT NULL DEFAULT 'Not Registered'
  constraint Consumer_pk primary key(cid),
  
) ;

CREATE TABLE DISTRIBUTOR_DETAIL(
  did int NOT NULL default 1 CHECK (did like replicate('[0-9]',1))  ,
  pwd varchar(16) NOT NULL,
  name varchar(20) NOT NULL,
  door_number varchar(100) NOT NULL,
  city varchar(10) NOT NULL,
  pin int NOT NULL,
  m_no bigint NOT NULL,
  e_id varchar(30) NOT NULL,
  status varchar(10) NOT NULL DEFAULT 'Deactive',
  proof varchar(40) NOT NULL,
  constraint Distributor_pk primary key(did)
) ;

CREATE TABLE FEEDBACK_COMPLAIN (
  oid int NOT NULL CHECK (oid like replicate('[0-9]',2)),
  Date date NOT NULL check(Date <= getdate()),
  Time time NOT NULL,
  Type varchar(10) NOT NULL,
  Subject varchar(30) NOT NULL,
  Description varchar(300) NOT NULL,
  constraint Feedback_pk primary key(oid)
); 

CREATE TABLE ORDER_DETAIL (
  oid int NOT NULL CHECK (oid like replicate('[0-9]',2)),
  cid int NOT NULL CHECK (cid like replicate('[0-9]',5)),
  did int NOT NULL CHECK (did like replicate('[0-9]',1)),
  Date date NOT NULL CHECK (Date <= getdate()),
  Time time NOT NULL,
  amt float NOT NULL DEFAULT '475',
  status varchar(20) NOT NULL DEFAULT 'Pending'
  constraint Order_pk primary key(oid)
);



Alter table CONSUMER_DETAIL add constraint Consumer_fk foreign key(did)
  references DISTRIBUTOR_DETAIL(did);
Alter table ORDER_DETAIL add constraint Order_fk1 foreign key(cid) references CONSUMER_DETAIL(cid);
Alter table ORDER_DETAIL add constraint Order_fk2 foreign key(did) references DISTRIBUTOR_DETAIL(did) ;
Alter table FEEDBACK_COMPLAIN add constraint Feedback_fk foreign key(oid) references ORDER_DETAIL;

INSERT INTO ADMIN VALUES
(1, 'rootroot');

INSERT INTO DISTRIBUTOR_DETAIL  VALUES
(1, '111111', 'Jai Ganesh Agency', 'D12, GIDC-Kapodra', 'Surat', 384511, 8200703812, 'jganesh@gmail.com', 'Active', 'distributor1.jpg'),
(2, '222222', 'Gitanjali PVT LTD', '12, Amazon plaza, Ring road', 'Ahmedabad', 355002, 8547856321, 'gpvtltd@hotmail.com', 'Active', 'distributor2.jpg'),
(9, '111111', 'Nandan LTD', '12, Birla Mart, Behind Maruti Chowk', 'Bhavnagar', 555656, 7898765421, 'nan@ymail.com', 'Active', 'distributor9.jpg'),
(6, '333333', 'Tapovan Group', 'A55, JZ Shopping Mart, LH road', 'Vadodara', 366444, 9875452121, 'tapo@gmail.com', 'Deactive', 'distributor10.png');

INSERT INTO CONSUMER_DETAIL  VALUES
(12345, 1, '111111', 'Raj Pravinbhai Zalavadiya', '201,Sai Darshan, Nana Varachha', 'Surat', 394525, 8787954652, 'raj@outlook.com', '2018-02-07', 'Deactive'),
(23412, 2, '333333', 'Biren V. Gadhiya', 'B12, Khodiyar row house, Katargam', 'Ahmedabad', 366666, 7877777777, 'bg@outlook.com', '2018-02-08', 'Active'),
(12323, 1, '555555', 'Jenish Kishorbhai Mangukiya', 'D2/304, Gangotri rec., Sudama chowk, Mota Varachha', 'Surat', 394101, 9904436106, 'mjenish8@gmail.com', '2018-02-09', 'Active'),
(22512, 1, '225225', 'Ravi K. Kanpara', '22', 'Surat', 388554, 8565655521, 'ravi@gmail.com', '2018-02-21', 'Active');

INSERT INTO ORDER_DETAIL VALUES
(10, 12345, 1, '2019-02-14', '10:07:17', 475, 'Delivered'),
(15, 12323, 1, '2019-02-14', '10:15:24', 475, 'Delivered'),
(18, 22512, 1, '2019-02-26', '10:04:35', 475, 'Approved'),
(19, 22512, 1, '2020-03-21', '18:36:45', 475, 'Delivered'),
(25, 23412, 2, '2020-04-06', '17:39:56', 475, 'Pending');

INSERT INTO FEEDBACK_COMPLAIN VALUES
(10, '2019-02-25', '10:34:46', 'Feedback', 'Product related', 'Last product delivery taken two weeks'),
(15, '2020-02-25', '10:35:48', 'Complaint', 'Defected Product', 'Delivered product is defected'),
(25, '2020-04-06', '18:14:48', 'Complaint', 'Notification related', 'Didnt get any notification');



/*CREATE TRIGGER tr_CONSUMER_DETAIL_ForInsert
ON CONSUMER_DETAIL
FOR INSERT
AS
BEGIN
         Declare @
		 
		 
Q 1
SELECT O.cid,O.did
from ORDER_DETAIL AS O
WHERE status LIKE '%Pending%'		 
		
A 1
SELECT did,count(*) AS no_of_customers
FROM CONSUMER_DETAIL group by did

A 2
Select did, sum(Amt) as Total_amt
From ORDER_DETAIL Group by did
		 
A 3
select c.cid, c.name
from CONSUMER_DETAIL AS c
WHERE c.cid in (SELECT cid
              FROM ORDER_DETAIL group by cid HAVING COUNT(did) > 1)	 
		 
		 
J 1
SELECT DISTINCT (D.did),D.name
FROM DISTRIBUTOR_DETAIL as D join
(FEEDBACK_COMPLAIN as F full outer join ORDER_DETAIL as O on F.oid=O.oid)
ON D.did=O.did
WHERE F.Type='Feedback'

J 2
Select D.did,D.name,C.cid,C.name
From CONSUMER_DETAIL as C join
(ORDER_DETAIL as O full outer join DISTRIBUTOR_DETAIL as D on O.did=D.did)
on C.cid=O.cid
WHERE O.status='Delivered'

J 3
Select C.cid,C.name,D.did,D.name
From (CONSUMER_DETAIL as C join (ORDER_DETAIL as O join FEEDBACK_COMPLAIN as F on O.oid=F.oid) on
C.cid =O.cid) join DISTRIBUTOR_DETAIL as D on C.did=D.did
		
		 
		 
C 1
SELECT c.cid,c.name,c.city
FROM CONSUMER_DETAIL AS c
WHERE  EXISTS (SELECT o.cid
                    FROM ORDER_DETAIL AS o
					 WHERE c.cid=o.cid)	 

C 2

SELECT DISTINCT(D.did),D.name
FROM ORDER_DETAIL as O left outer join DISTRIBUTOR_DETAIL as D  on O.did=D.did
WHERE exists ( SELECT DISTINCT(F.oid)
               FROM FEEDBACK_COMPLAIN as F
			   WHERE F.Type='Complaint' and F.oid=O.oid)
		 

C 3

SELECT c.cid,c.name
FROM CONSUMER_DETAIL AS c
WHERE EXISTS (SELECT o.cid
                    FROM ORDER_DETAIL AS o
					 WHERE c.cid=o.cid AND o.status='Pending')	
			
TRIGGER 1
CREATE TRIGGER ord_ins
ON ORDER_DETAIL
FOR INSERT 
AS
  BEGIN
    SET NOCOUNT ON
	  print 'trigger fired'
      If (SELECT did FROM INSERTED) IN (1,2,9)
      Begin
		Return
	  End
	  else
	  print 'THE TUPLE CANNOT BE INSERTED'
	  

	  INSERT INTO ORDER_DETAIL
      (
        oid,
        cid,
        did,
        Date,
		Time,
		amt,
		status
      )
    SELECT
        oid,
        cid,
        did,
        Date,
		Time,
		amt,
		status
    FROM Inserted AS I
END

T 2
create trigger dis_ins
on DISTRIBUTOR_DETAIL
after insert
as
begin  
  select * from DISTRIBUTOR_DETAIL
end
	
*/