Select count(StaffID)AS 'StaffNumber' From Staff
Select timeBooked, DateBooked from Booking Where MemberNRIC = 'S6100888A'
Select s.serviceName from NPService s inner join Booking b on s.serviceID = b.ServiceID where b.bookingNo= 1 
Select totalAmount from productreceipt where receiptNo = 10101010
select * from npservice
select s.serviceDesc,m.memberName from npservice s cross Join member m where m.memberNRIC = 'S8100777P' 
select count(staffID) As 'Number of Staff' from staff where branchNO = 3 
select membercontactNo from member 
select m.membername, s.staffname from member m cross join staff s order by  s.staffname asc  
select memberNRIC, memberName from member 
select staffID, staffname from staff
select BranchNo, count(StaffID) As "Number of staff"
		From Staff
		Group by BranchNO 
		having Count(StaffID)>1 
		
Select se.serviceID, s.subtotal from ServiceReceipt s cross Join ServiceDetail se where s.ReceiptNo = 1010102    		

SELECT BranchNo, COUNT(MemberID) As "Number of Members" 
	  From Member 
	  Group by BranchNo 
	  Having COUNT (MemberID)>=3