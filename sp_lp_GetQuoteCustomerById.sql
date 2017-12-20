USE [Dev_Leasing_EnquiryFields]
GO
/****** Object:  StoredProcedure [dbo].[sp_lp_GetQuoteCustomerById]    Script Date: 20/12/2017 10:43:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_lp_GetQuoteCustomerById]
	@ID int
AS
	SET NOCOUNT ON
	Select
		[ID],
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
		[EeIdLink] As EEID,
		[EeIdLink],
		[DateCreated],
		[Username],
		[SiteID],
		[PayrollGroup],
		[ErID],
		Cast(IsNUll(HasHECSDebt, 0) as bit) [HasHECSDebt],
		Cast(IsNUll(IsClaimingTax, 0) as bit) [IsClaimingTax],
		[IsStaffSpecialist],
		[IsMinisterReligion]
	From LP_Customer
	Where [ID] = @ID