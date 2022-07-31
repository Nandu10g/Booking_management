SELECT O.cid,O.did
from ORDER_DETAIL AS O
WHERE status LIKE '%Pending%'

select *  FROM ADMIN

select *  FROM FEEDBACK_COMPLAIN

select *  FROM CONSUMER_DETAIL

select *  FROM DISTRIBUTOR_DETAIL

select *  FROM ORDER_DETAIL

SELECT did,count(*) AS no_of_customers
FROM CONSUMER_DETAIL group by did


Select did, sum(Amt) as Total_amt
From ORDER_DETAIL Group by did

select c.cid, c.name
from CONSUMER_DETAIL AS c
WHERE c.cid in (SELECT cid
              FROM ORDER_DETAIL group by cid HAVING COUNT(did) > 1)


select DISTINCT (D.did),D.name
from DISTRIBUTOR_DETAIL as D join
(FEEDBACK_COMPLAIN as F full outer join ORDER_DETAIL as O on F.oid=O.oid)
ON D.did=O.did

Select D.did,D.name,C.cid,C.name
From CONSUMER_DETAIL as C join
(ORDER_DETAIL as O full outer join DISTRIBUTOR_DETAIL as D on O.did=D.did)
on C.cid=O.cid
WHERE O.status='Delivered'

Select C.cid,C.name,D.did,D.name
From (CONSUMER_DETAIL as C join (ORDER_DETAIL as O join FEEDBACK_COMPLAIN as F on O.oid=F.oid) on
C.cid =O.cid) join DISTRIBUTOR_DETAIL as D on C.did=D.did

SELECT c.cid,c.name,c.city
FROM CONSUMER_DETAIL AS c
WHERE  EXISTS (SELECT o.cid
                    FROM ORDER_DETAIL AS o
					 WHERE c.cid=o.cid)

INSERT INTO CONSUMER_DETAIL  VALUES
(14785, 9, '122111', 'Rahul', '202-11 A Sai Surya Heights', 'Bhavnagar', 362525, 6307954652, 'rahul@gmail.com', '2020-02-07', 'active');

DELETE FROM CONSUMER_DETAIL
WHERE cid=14785

DELETE FROM DISTRIBUTOR_DETAIL
WHERE did=0

SELECT DISTINCT(D.did),D.name
FROM ORDER_DETAIL as O left outer join DISTRIBUTOR_DETAIL as D  on O.did=D.did
WHERE exists ( SELECT DISTINCT(F.oid)
               FROM FEEDBACK_COMPLAIN as F
			   WHERE F.Type='Complaint' and F.oid=O.oid)

SELECT DISTINCT (D.did),D.name
FROM DISTRIBUTOR_DETAIL as D join
(FEEDBACK_COMPLAIN as F full outer join ORDER_DETAIL as O on F.oid=O.oid)
ON D.did=O.did
WHERE F.Type='Feedback'

SELECT c.cid,c.name
FROM CONSUMER_DETAIL AS c
WHERE EXISTS (SELECT o.cid
                    FROM ORDER_DETAIL AS o
					 WHERE c.cid=o.cid AND o.status='Pending')

CREATE TRIGGER dis_ins 
on DISTRIBUTOR_DETAIL
AFTER INSERT
as 
declare @did int;
declare @pwd varchar(16);
declare @name varchar(20);
declare @Date date;
declare @Time time;
declare @amt float;
declare @status varchar(20);
select
@oid=i.oid,@cid=i.cid,@did=i.did,@Date=i.Date,@Time=i.Time,@status=i.status 
from inserted i;
if (SELECT  and status='pending')
THEN
print 'you cant insert'

DROP TRIGGER ord_ins

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
        oid, cid, did, Date, Time, amt, status
      )
    SELECT
        oid, cid, did, Date, Time, amt, status
    FROM Inserted AS I
END

INSERT INTO ORDER_DETAIL VALUES
(70, 12345, 1, '2020-04-14', '10:07:17', 475, 'Pending');


create trigger dis_ins
on DISTRIBUTOR_DETAIL
after insert
as
begin  
  select * from DISTRIBUTOR_DETAIL
end

INSERT INTO DISTRIBUTOR_DETAIL  VALUES
(5, '555555', 'Amaravathi Agency', '88-104 park road raj nagar', 'Hyderabad', 518511, 9524703812, 'amaravathi@gmail.com', 'Active', 'distributor5.jpg');

