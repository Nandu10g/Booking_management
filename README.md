# sqlquery
Gas Booking management System is implemented here, using SQL. The 
objective of this project is to create the system where the customer can easily 
book their gas cylinder and agency can track the record of its customer and the 
order details of the cylinder. Tables have been created by taking care of all the 
constraints. Primary and foreign keys have been defined properly.
This data model contains 5 tables namely ADMIN, CONSUMER_DETAIL, 
DISTRIBUTOR_DETAIL, FEEDBACK_COMPLAIN, ORDER_DETAIL.
Two triggers have been implemented here, one on DISTRIBUTOR_DETAIL table 
Whenever a new tuple is added the entire table gets displayed and the second 
trigger is for, whenever a distributor service is inactive this trigger prevents the 
consumer from placing the order from that particular distributor. Several queries 
have been made to retrieve the required information.
On the conclusion note, This system provides the facility to handle and manage 
details of consumer, distributor and order status. This system is simple and easy 
to maintain. The system also handles the feedback and complaints of 
consumers. This shows the real world working scenario of gas management 
system
