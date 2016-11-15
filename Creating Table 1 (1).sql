Create Database NailPalaces
GO

use NailPalaces
GO

drop table Member
/*** Create tables ***/

/* Table: Member */
CREATE TABLE Member
(	
  MemberNRIC 			char(9)			NOT NULL,
  MemberName			varchar(50) 	NOT NULL,
  MemberGender			char(1) 		NOT NULL	CHECK (MemberGender IN ('M','F')),
  MemberBirthDate		datetime		NOT NULL,
  MemberContactNo		char(10)		NOT NULL,
  MemberAddress			varchar(150) 	NOT NULL,
  MemberEmailAddr		varchar(50)		NULL,
  MemberDateJoin		datetime		NOT NULL,
  CONSTRAINT PK_Member PRIMARY KEY (MemberNRIC)  
)

GO

/* Table: Branch */
CREATE TABLE Branch
(
  BranchNo	 			int,            
  BranchName 			varchar(50)		NOT NULL,
  BranchAddress			varchar(150)	NOT NULL,
  BranchContactNo		varchar(10)		NOT NULL,
  CONSTRAINT PK_Branch PRIMARY KEY (BranchNo)
)

Go

/* Table: Product */
CREATE TABLE Product
(
  ProductID 		int				IDENTITY(11111111, 10),
  ProductPrice		smallmoney		NOT NULL,
  ProductName		varchar(50)		NOT NULL,  
  ProductDesc		varchar(200)	NULL,
  ProductOrigin		varchar(50)		NOT NULL, 
  Manufacturer 		varchar(50) 	NOT NULL,
  ProductExpiryDate	datetime		NULL,
  CONSTRAINT PK_Product PRIMARY KEY (ProductID)
)
/* Table: ProductDetail */
CREATE TABLE ProductDetail
(
	ProductID			int			NOT NULL,
	DateBought			datetime	NOT NULL,
	ProductName			varchar(50)	NOT NULL,
	ProductPrice		money		NOT NULL,
	ProductQuantity		int			NOT NULL,
	ReceiptNo			int			NOT NULL,	
	CONSTRAINT PK_ProductDetail PRIMARY KEY (ProductID, DateBought),
	CONSTRAINT FK_ProductDetail_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	CONSTRAINT FK_ProductDetail_ReceiptNo FOREIGN KEY (ReceiptNo) REFERENCES ProductReceipt(ReceiptNo)
)
/* Table: ProductReceipt */
CREATE TABLE ProductReceipt
(
  ReceiptNo			int			IDENTITY(10101010, 1),
  Subtotal			money		NOT NULL,
  AmountOfGST		money		NOT NULL,
  TotalAmount		money		NOT NULL,
  Change			money		NULL,
  PaymentMode		varchar(20)	NOT NULL, 
  PaymentAmount		money		NULL, 
  StaffID			varchar(10)	NOT NULL,
  PaySlipNo			int			NOT NULL,
  CONSTRAINT PK_ProductReceipt PRIMARY KEY (ReceiptNo),
  CONSTRAINT FK_Receipt_StaffID FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  CONSTRAINT FK_ProductReceipt_PaySlipNo FOREIGN KEY (PaySlipNo) REFERENCES PaySlip(PaySlipNo)
)


GO
/* Table: Stock */
CREATE TABLE Stock
(
  BranchNo	 			int,
  ProductID				int				NOT NULL,
  Quantity				int				NOT NULL,
  CONSTRAINT PK_Stock PRIMARY KEY (BranchNo, ProductID),
  CONSTRAINT FK_Stock_BranchNo FOREIGN KEY (BranchNo) REFERENCES Branch(BranchNo),
  CONSTRAINT FK_Stock_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

GO

/* Table: Staff  */
CREATE TABLE Staff 
(
  StaffID				varchar(10),
  StaffName				varchar(50) 	NOT NULL,
  StaffGender			char(1) 		NOT NULL	CHECK (StaffGender IN ('M','F')),
  StaffContactNo		varchar(10)		NOT NULL,
  StaffDateJoin			datetime		NOT NULL,
  BasicSalary			smallmoney		NOT NULL,
  BranchNo				int				NOT NULL,
  CONSTRAINT PK_Staff PRIMARY KEY (StaffID),
  CONSTRAINT FK_Staff_BranchNo FOREIGN KEY (BranchNo) REFERENCES Branch(BranchNo)
)


GO

/* Table: Pay Slip */
CREATE TABLE PaySlip
(
  PaySlipNo			int				IDENTITY(1,1),	
  StaffID			varchar(10)		NOT NULL,
  PaySlipDate		datetime		NOT NULL, 
  Commission		money			NOT NULL,
  TotalSalary		money			NOT NULL,
  CONSTRAINT PK_PaySlip PRIMARY KEY (PaySlipNo),
  CONSTRAINT FK_PaySlip_StaffID FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
)


GO

/* Table: Service */
CREATE TABLE NPService
(
  ServiceID 			int				IDENTITY(10010001, 10),
  ServiceName			varchar(50)		NOT NULL, 
  ServiceDesc			varchar(100)	NULL,
  ServicePrice			money			NOT NULL, 
  ServiceDuration		varchar(5)		NOT NULL,
  CONSTRAINT PK_NPService PRIMARY KEY (ServiceID)
)
Go

/* Table: ServiceDetail */
CREATE TABLE ServiceDetail
(
	ServiceID			int			NOT NULL,
	ServiceName			varchar(50)	NOT NULL,
	ServicePrice		money		NOT NULL,
	DateServiced		datetime	NOT NULL,
	ReceiptNo			int			NOT NULL,
	CONSTRAINT PK_ServiceDetail PRIMARY KEY (ServiceID, DateServiced),
	CONSTRAINT FK_ServiceDetail FOREIGN KEY (ServiceID) REFERENCES NPService(ServiceID),
	CONSTRAINT FK_ServiceDetail_ReceiptNo FOREIGN KEY (ReceiptNo) REFERENCES ServiceReceipt(ReceiptNo)
)

GO

/* Table: ServiceReceipt */
CREATE TABLE ServiceReceipt
(
	ReceiptNo			int			IDENTITY(01010101, 1),
	Subtotal			money		NOT NULL,
	AmountOfGST			money		NOT NULL,
	TotalAmount			money		NOT NULL,
	Change				money		NULL,
	PaymentMode			varchar(20)	NOT NULL, 
	PaymentAmount		money		NULL, 
	StaffID				varchar(10)	NOT NULL,
	PaySlipNo			int			NOT NULL,
	CONSTRAINT PK_ServiceReceipt PRIMARY KEY (ReceiptNo),
	CONSTRAINT FK_ServiceReceipt_StaffID FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
	CONSTRAINT FK_ServiceReceipt_PaySlipDate FOREIGN KEY (PaySlipNo) REFERENCES PaySlip(PaySlipNo)
)


Go

/* Table: Booking */
CREATE TABLE Booking 
(
  BookingNo		int			IDENTITY(0001, 1),
  SeatNo		int			NOT NULL,
  DateBooked	datetime	NOT NULL,
  TimeBooked	datetime	NOT NULL,
  EndTimeBooked datetime	NOT NULL,
  ServiceID		int			NOT NULL,
  MemberNRIC	char(9)		NOT NULL,
  CONSTRAINT PK_Booking PRIMARY KEY (BookingNo),
  CONSTRAINT FK_Booking_ServiceID FOREIGN KEY (ServiceID) REFERENCES NPService(ServiceID),
  CONSTRAINT FK_Booking_MemberNRIC FOREIGN KEY (MemberNRIC) REFERENCES Member(MemberNRIC)
)



SELECT * FROM Booking
SELECT * FROM Branch
SELECT * FROM Member
SELECT * FROM NPService
SELECT * FROM PaySlip
SELECT * FROM Product
SELECT * FROM ProductDetail
SELECT * FROM ProductReceipt
SELECT * FROM ServiceDetail
SELECT * FROM ServiceReceipt
SELECT * FROM Staff
SELECT * FROM Stock


/***** Create Records in Service Detail *****/
DELETE ServiceDetail
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010001', 'Express Manicure', '9.9', '07-09-2011', '1010101')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010011', 'Express Pedicure', '11.9', '07-18-2011', '1010101')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010021', 'Classic Manicure', '17.9', '07-19-2011', '1010101')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010031', 'Classic Pedicure', '19.9', '07-20-2011', '1010101')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010001', 'Express Manicure', '9.9', '07-11-2011', '1010102')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010011', 'Express Manicure', '11.9', '07-13-2011', '1010102')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010021', 'Express Manicure', '17.9', '07-15-2011', '1010102')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010031', 'Express Pedicure', '19.9', '07-17-2011', '1010102')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010001', 'Express Manicure', '9.9', '07-10-2011', '1010103')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010011', 'Express Manicure', '11.9', '07-12-2011', '1010103')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010021', 'Express Manicure', '17.9', '07-14-2011', '1010103')
INSERT INTO ServiceDetail(ServiceID, ServiceName, ServicePrice, DateServiced, ReceiptNo)
VALUES ('10010031', 'Express Pedicure', '19.9', '07-16-2011', '1010103')



/***** Create Records in Service Receipt *****/
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '0.46', 'Cash', '11', 'ZD0106', 1)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '1.46', 'Cash', '12', 'ZD0106', 1)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ZD0106', 1)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ZD0106', 1)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '9.46', 'Cash', '20', 'ZD0106', 1)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ZD0106', 1)

INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '0.46', 'Cash', '11', 'ST0106', 2)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '1.46', 'Cash', '12', 'ST0106', 2)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ST0106', 2)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ST0106', 2)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '9.46', 'Cash', '20', 'ST0106', 2)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'ST0106', 2)

INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '0.46', 'Cash', '11', 'M0106', 3)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '1.46', 'Cash', '12', 'M0106', 3)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'M0106', 3)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'M0106', 3)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '9.46', 'Cash', '20', 'M0106', 3)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'M0106', 3)

INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '0.46', 'Cash', '11', 'EK0506', 4)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '1.46', 'Cash', '12', 'EK0506', 4)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'EK0506', 4)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'EK0506', 4)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '9.46', 'Cash', '20', 'EK0506', 4)
INSERT INTO ServiceReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES ('9.9', '0.64', '10.54', '4.46', 'Cash', '15', 'EK0506', 4)

/***** Create Records in Product Detail *****/
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111171', '07-11-2011', 'Nail Polish(Transparent)', 2, '6', '10101020')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111181', '07-11-2011', 'Nail Polish Removal', 1, '4', '10101020')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111191', '07-11-2011', 'Cotton Wool(30)', 1, '2', '10101020')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111151', '07-13-2011', 'Nail Polish(Pink)', 2, '6', '10101021')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111181', '07-13-2011', 'Nail Polish Removal', 1, '4', '10101021')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111191', '07-13-2011', 'Cotton Wool(30)', 1, '2', '10101021')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111151', '07-15-2011', 'Nail Polish(Pink)', 2, '6', '10101022')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111181', '07-15-2011', 'Nail Polish Removal', 1, '4', '10101022')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111191', '07-15-2011', 'Cotton Wool(30)', '2', 1, '10101022')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111161', '07-17-2011', 'Nail Polish(Yellow)', 2, '6', '10101023')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111181', '07-17-2011', 'Nail Polish Removal', 1,'4', '10101023')
INSERT INTO ProductDetail(ProductID, DateBought, ProductName, ProductQuantity, ProductPrice, ReceiptNo)
VALUES('11111191', '07-17-2011', 'Cotton Wool(30)', 1, '2', '10101023')


/***** Create Records in Product Receipt *****/
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '0.0', 'Cash', '12.8', 'ZD0106', 1)

INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '2.2', 'Cash', '15', 'ST0106', 2)


INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '12.8', '6.2', 'Cash', '20', 'M0106', 3)


INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)
INSERT INTO ProductReceipt(Subtotal, AmountOfGST, TotalAmount, Change, PaymentMode, PaymentAmount, StaffID, PaySlipNo)
VALUES('12', '0.8', '23.4', '0.2', 'Cash', '13', 'EK0506', 4)

/***** Create records in PaySlip Table *****/
INSERT INTO PaySlip(StaffID, PaySlipDate, Commission, TotalSalary)
VALUES('ZD0106', '08/01/2011', '10.95', '3010.95')
INSERT INTO PaySlip(StaffID, PaySlipDate, Commission, TotalSalary)
VALUES('ST0106', '08/01/2011', '10.95', '3010.95')
INSERT INTO PaySlip(StaffID, PaySlipDate, Commission, TotalSalary)
VALUES('M0106', '08/01/2011', '10.95', '3010.95')
INSERT INTO PaySlip(StaffID, PaySlipDate, Commission, TotalSalary)
VALUES('EK0506', '08/01/2011', '10.95', '3010.95')


/***** Create records in Stock Table *****/

INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111111', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111121', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111131', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111141', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111151', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111161', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111171', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111181', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111191', 100)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111201', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111211', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (1, '11111221', 50)

INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111111', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111121', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111131', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111141', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111151', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111161', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111171', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111181', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111191', 100)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111201', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111211', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (2, '11111221', 50)

INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111111', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111121', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111131', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111141', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111151', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111161', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111171', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111181', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111191', 100)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111201', 30)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111211', 50)
INSERT INTO Stock(BranchNo, ProductID, Quantity)
VALUES (3, '11111221', 50)

/*****	Create records in Product Table *****/
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Black)', 'A black colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Red)', 'A red colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Green)', 'A green colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Sky Blue)', 'A sky blue colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Yellow)', 'A yellow colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Pink)', 'A pink colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('3', 'Nail Polish(Transparent)', 'A transparent colour nail polisher', 'China', 'ChinaApple', '11-11-2012')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer, ProductExpiryDate)
VALUES ('4', 'Nail Polish Removal', 'A nail polisher removal', 'Thailand', 'ThailandApple', '11-11-2013')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer)
VALUES ('2', 'Cotton Wool(30)', 'A pack of cotton wool', 'Thailand', 'ThailandApple')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer)
VALUES ('1.5', 'Nail Cutter', 'A nail cutter', 'China', 'ChinaApple')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer)
VALUES ('1', 'Nail Sticker', 'A design nail sticker', 'China', 'ChinaApple')
INSERT INTO Product(ProductPrice, ProductName, ProductDesc, ProductOrigin, Manufacturer)
VALUES ('3', 'Nail Filler', 'A nail filler', 'Singapore', 'SingaporeApple')


/*****  Create records in Booking Table *****/
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (1, '07/11/2011', '12pm', '12:30pm', '10010001', 'S6100888A')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (2, '07/11/2011', '12pm', '12:30pm', '10010001', 'S8100777P')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (3, '07/11/2011', '12pm', '12:30pm', '10010001', 'S7700666B')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (1, '07/13/2011', '1pm', '1:30pm', '10010011', 'S6100888A')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (2, '07/13/2011', '1pm', '1:30pm', '10010011', 'S8100777P')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (3, '07/13/2011', '1pm', '1:30pm', '10010011', 'S7700666B')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (1, '07/15/2011', '1pm', '2pm', '10010031', 'S6100888A')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (1, '07/15/2011', '2pm', '3pm', '10010031', 'S8100777P')
INSERT INTO Booking(SeatNo, DateBooked, TimeBooked, EndTimeBooked, ServiceID, MemberNRIC)
VALUES (2, '07/15/2011', '1pm', '2pm', '10010031', 'S7700666B')

/*****  Create records in Service Table *****/
INSERT INTO NPService(ServiceName, ServiceDesc, ServicePrice, ServiceDuration)
VALUES ('Express Manicure', 'A Simply Done Manicure In Short Duration', '9.90', '30min')
INSERT INTO NPService(ServiceName, ServiceDesc, ServicePrice, ServiceDuration)
VALUES ('Express Pedicure', 'A Simply Done Pedicure In Short Duration', '11.90', '30min')
INSERT INTO NPService(ServiceName, ServiceDesc, ServicePrice, ServiceDuration)
VALUES ('Classic Manicure', 'A Manicure Done In A Longer Duration', '17.90', '1hrs')
INSERT INTO NPService(ServiceName, ServiceDesc, ServicePrice, ServiceDuration)
VALUES ('Classic Pedicure', 'A Pedicure Done In A Longer Duration', '19.90', '1hrs')

/*****  Create records in Staff Table *****/
insert into Staff (StaffID, StaffName, StaffGender, StaffContactNo, StaffDateJoin , BasicSalary, BranchNo)
values ('ZD0106', 'Zong Dong', 'M', '93896799', '07/01/2011', '3000', '1')
insert into Staff (StaffID, StaffName, StaffGender, StaffContactNo, StaffDateJoin, BasicSalary, BranchNo)
values ('ST0106', 'Sau Teng', 'F', '91111111', '07/01/2011', '3000', '2')
insert into Staff (StaffID, StaffName, StaffGender, StaffContactNo, StaffDateJoin, BasicSalary, BranchNo)
values ('M0106', 'Mcvie', 'M', '93333333', '07/01/2011', '3000', '3')
insert into Staff (StaffID, StaffName, StaffGender, StaffContactNo, StaffDateJoin, BasicSalary, BranchNo)
values ('EK0506', 'Eng Kong', 'M', '95555555', '07/01/2011', '3000', '2')

/*****  Create records in Branch Table *****/
INSERT INTO Branch(BranchNo, BranchName, BranchAddress, BranchContactNo)
VALUES (1, 'Ang Mo Kio NP', 'Ang Mo Kio Avenue 5', '65551111')
INSERT INTO Branch(BranchNo, BranchName, BranchAddress, BranchContactNo)
VALUES (2, 'Bishan NP', 'Bishan Avenue 10', '65552222')
INSERT INTO Branch(BranchNo, BranchName, BranchAddress, BranchContactNo)
VALUES (3, 'Orchard NP', 'Orchard Avenue 3', '65553333')

/*****  Create records in Member Table *****/
insert into Member(MemberNRIC , MemberName, MemberGender, MemberBirthDate, MemberContactNo, MemberAddress, MemberEmailAddr, MemberDateJoin)
values ('S6100888A', 'Peter Ghim', 'M', '04-Jan-1981', '98761234', 'Blk 123 #01-123 Apple Road Singapore 670123', 'pg61@hotmail.com','07/15/2011')
insert into Member(MemberNRIC , MemberName, MemberGender, MemberBirthDate, MemberContactNo, MemberAddress, MemberEmailAddr, MemberDateJoin)
values ('S8100777P', 'Pinky Pander', 'F', '24-Dec-1981', '91234567', 'Blk 456 #01-456 Pineapple Road Singapore 670456', 'pp81@yahoo.com', '07/15/2011')
insert into Member(MemberNRIC , MemberName, MemberGender, MemberBirthDate, MemberContactNo, MemberAddress, MemberEmailAddr, MemberDateJoin)
values ('S7700666B', 'Benjamin Bean', 'M', '07-Jul-1977', '88887777', 'Blk 789 #01-789 Orange Road Singapore 670789', 'bb77@gmail.com', '07/15/2011')