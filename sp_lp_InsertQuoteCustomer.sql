USE [Dev_Leasing_EnquiryFields]
GO

/****** Object:  StoredProcedure [dbo].[sp_lp_InsertQuoteCustomer]    Script Date: 20/12/2017 10:27:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_lp_InsertQuoteCustomer]
	@title varchar(20),
	@firstName varchar(20),
	@middlename varchar(20),
	@lastName varchar(20),
	@employer varchar(100),
	@email varchar(255),
	@phone varchar(50),
	@phoneWork varchar(14),
	@phoneMobile varchar(50),
	@fax varchar(14),
	@deliverySuburb varchar(30),
	@deliveryPostcode varchar(4),
	@deliveryState varchar(3),
	@comments text,
	@partnerID int,
	@heardAboutUs nvarchar(10),
	@heardAboutUsOther nvarchar(50),
	@baseSalary money,
	@dOB datetime,
	@qualified bit,
	@isUnderProbationaryPeriod bit,
	@payrollNo nvarchar(20),
	@payFrequency int,
	@costcenter nvarchar(100),
	@latitude decimal(10,6),
	@longitude decimal(10,6),
	@brokerId int,
	@eEID int,
	@username nvarchar(100),
	@siteID int,
	@payrollGroup int,
	@erID int,
	@hasHECSDebt bit,
	@isClaimingTax bit,
	@ID int output 
AS
	Declare @searchKey nvarchar(500)
	
	set @searchKey=REPLACE(@firstName, ' ', '') + REPLACE(@lastName, ' ', '')+ REPLACE(@email, ' ', '');
	SET NOCOUNT ON
	Insert into LP_Customer(
		[Title],
		[FirstName],
		[Middlename],
		[LastName],
		[Employer],
		[Email],
		[Phone],
		[PhoneWork],
		[PhoneMobile],
		[Fax],
		[DeliverySuburb],
		[DeliveryPostcode],
		[DeliveryState],
		[Comments],
		[PartnerID],
		[HeardAboutUs],
		[HeardAboutUsOther],
		[BaseSalary],
		[DOB],
		[qualified],
		[isUnderProbationaryPeriod],
		[payrollNo],
		[PayFrequency],
		[Costcenter],
		[Latitude],
		[Longitude],
		[BrokerId],
		[SearchKey],
		[EeIdLink],
		[Username],
		[SiteID],
		[PayrollGroup],
		[ErID],
		[HasHECSDebt],
		[IsClaimingTax])
	Values (
		@title,
		@firstName,
		@middlename,
		@lastName,
		@employer,
		@email,
		@phone,
		@phoneWork,
		@phoneMobile,
		@fax,
		@deliverySuburb,
		@deliveryPostcode,
		@deliveryState,
		@comments,
		@partnerID,
		@heardAboutUs,
		@heardAboutUsOther,
		@baseSalary,
		@dOB,
		@qualified,
		@isUnderProbationaryPeriod,
		@payrollNo,
		@payFrequency,
		@costcenter,
		@latitude,
		@longitude,
		@brokerId,
		@searchKey,
		@eEID,
		@username,
		@siteID,
		@payrollGroup,
		@erID,
		@hasHECSDebt,
		@isClaimingTax)
	set @ID = scope_identity()
GO


