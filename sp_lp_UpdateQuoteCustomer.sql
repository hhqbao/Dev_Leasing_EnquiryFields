USE [Dev_Leasing_EnquiryFields]
GO
/****** Object:  StoredProcedure [dbo].[sp_lp_UpdateQuoteCustomer]    Script Date: 20/12/2017 10:50:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_lp_UpdateQuoteCustomer]
	@iD int,
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
	@searchKey varchar(500),
	@eEID int,
	@username nvarchar(100),
	@siteID int,
	@payrollGroup int,
	@erID int,
	@hasHECSDebt bit,
	@isClaimingTax bit
AS
	Update LP_Customer
	Set
		[Title] = @title,
		[FirstName] = @firstName,
		[Middlename] = @middlename,
		[LastName] = @lastName,
		[Employer] = @employer,
		[Email] = @email,
		[Phone] = @phone,
		[PhoneWork] = @phoneWork,
		[PhoneMobile] = @phoneMobile,
		[Fax] = @fax,
		[DeliverySuburb] = @deliverySuburb,
		[DeliveryPostcode] = @deliveryPostcode,
		[DeliveryState] = @deliveryState,
		[Comments] = @comments,
		[PartnerID] = @partnerID,
		[HeardAboutUs] = @heardAboutUs,
		[HeardAboutUsOther] = @heardAboutUsOther,
		[BaseSalary] = @baseSalary,
		[DOB] = @dOB,
		[qualified] = @qualified,
		[isUnderProbationaryPeriod] = @isUnderProbationaryPeriod,
		[payrollNo] = @payrollNo,
		[PayFrequency] = @payFrequency,
		[Costcenter] = @costcenter,
		[Latitude] = @latitude,
		[Longitude] = @longitude,
		[BrokerId] = @brokerId,
		--[SearchKey] = @searchKey, // Searchkey will be generated and recorded only once
		[EeIdLink] = @eEID,
		[Username] = @username,
		[SiteID] = @siteID,
		[PayrollGroup]=@payrollGroup,
		[ErID] = @erID,
		[HasHECSDebt] = @hasHECSDebt,
		[IsClaimingTax] = @isClaimingTax
	Where
	ID = @iD