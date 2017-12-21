/****** Object:  Table [dbo].[Employers]    Script Date: 21/12/2017 8:50:58 AM ******/
ALTER TABLE Employers ADD EmployerTypeId int
ALTER TABLE Employers ADD MaximumLeases smallint
ALTER TABLE Employers ADD IsGstDeducted bit
ALTER TABLE Employers ADD IsGstEquivalent bit
ALTER TABLE Employers ADD IsItcRefunded bit
ALTER TABLE Employers ADD AllowLuxuryVehicle bit
ALTER TABLE Employers ADD LuxuryVehicleCharged bit
ALTER TABLE Employers ADD AllowOperationCost bit
ALTER TABLE Employers ADD AllowExtraFields bit
/****** ****************************************************************************** ******/

/****** Object:  Table [dbo].[EmployerFrequency]    Script Date: 21/12/2017 8:50:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmployerFrequency](
	[ErId] [int] NOT NULL,
	[Frequency] [smallint] NOT NULL,
 CONSTRAINT [PK_EmployerFrequency] PRIMARY KEY CLUSTERED 
(
	[ErId] ASC,
	[Frequency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EmployerFrequency]  WITH CHECK ADD  CONSTRAINT [FK_EmployerFrequency_Frequency] FOREIGN KEY([Frequency])
REFERENCES [dbo].[Frequency] ([Frequency])
GO

ALTER TABLE [dbo].[EmployerFrequency] CHECK CONSTRAINT [FK_EmployerFrequency_Frequency]
GO
/****** ****************************************************************************** ******/

/****** Object:  Table [dbo].[LP_Customer]    Script Date: 21/12/2017 8:50:58 AM ******/
ALTER TABLE LP_Customer ADD HasHECSDebt bit
ALTER TABLE LP_Customer ADD IsClaimingTax bit
ALTER TABLE LP_Customer ADD IsStaffSpecialist bit
ALTER TABLE LP_Customer ADD IsMinisterReligion bit
ALTER TABLE LP_Customer ADD RealBaseSalary decimal(18,2)
/****** ****************************************************************************** ******/

/****** Object:  StoredProcedure [dbo].[sp_lp_GetEmployerById]    Script Date: 12/12/2017 1:32:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_lp_GetEmployerById]
	
	@erid int

AS
BEGIN

	select	er.erid, 
			isnull(ErName,'') as [Company Name], 
			isnull(PostalAddress1,'') as PostalAddress1, 
			isnull(PostalAddress2, '') as PostalAddress2,
			isnull(PostalAddress3, '') as PostalAddress3, 
			isnull(PostalCity, '') as PostalCity, 
			isnull(PostalState, '') as PostalState, 
			isnull(PostalPostCode, '') as PostalPostCode, 
			isnull(PhoneWork, '') as Phone, 
			isnull(Fax, '') as  Fax,
			isnull(Email, '') as  Email,
			isnull(GSTPaidInDeduction, '') as GSTPaidInDeduction, 
			isnull(CollectFBT, '') as CollectFBT,
			isnull(NovatedLeasingType , '') as NovatedLeasingType,
			isnull(Logo,'') as Logo, 
			er.employergroupid,			   
			er.ParentID,
			isnull(er.PartnerID,0) as PartnerID,
			isnull(Website,'') as Website,
			isnull(Abn,'') as Abn,
			isnull(Acn,'') as Acn,
			isnull(AssignedTo,'') as AssignedTo,
			isnull(Address,'') as Address,
			isnull(City,'') as City,
			isnull(PostCode,'') as PostCode,
			isnull(State,'') as State,
			isnull(Industry,'') as Industry,
			isnull(AboutCompany,'') as AboutCompany,
			isnull(er.Active,'') as Active,
			ISNULL(er.EmployerTypeId, -1) as EmployerTypeId,
			ISNULL(er.MaximumLeases, -1) as MaximumLeases,
			Cast(ISNULL(er.IsGstDeducted, 0) as bit) as IsGstDeducted,
			Cast(ISNULL(er.IsGstEquivalent, 0) as bit) as IsGstEquivalent,
			Cast(ISNULL(er.IsItcRefunded, 0) as bit) as IsItcRefunded,
			Cast(ISNULL(er.AllowLuxuryVehicle, 0) as bit) as AllowLuxuryVehicle,
			Cast(ISNULL(er.LuxuryVehicleCharged, 0) as bit) as LuxuryVehicleCharged,
			Cast(ISNULL(er.AllowOperationCost, 0) as bit) as AllowOperationCost,			
			Cast(ISNULL(er.AllowExtraFields, 0) as bit) as AllowExtraFields,
			longitude,
			latitude,
			er.brokerid,
			er.agentid,
			ext.PackagingProviderId, 
			LP_PackagingProvider.InvoicingPartnerId 
FROM            LP_PackagingProvider RIGHT OUTER JOIN
                         EmployersExt AS ext ON LP_PackagingProvider.ID = ext.PackagingProviderId RIGHT OUTER JOIN
                         View_LP_Employer AS er ON ext.Erid = er.ErId

	where er.erid = @erid
END
/****** ****************************************************************************** ******/

/****** Object:  StoredProcedure [dbo].[sp_lp_GetEmployersList]    Script Date: 18/12/2017 3:07:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_lp_GetEmployersList] 
(
	@showInactive bit
)
AS
BEGIN
	
	select	er.erid, 
			isnull(ErName,'') as [Company Name], 
			isnull(PostalAddress1,'') as PostalAddress1, 
			isnull(PostalAddress2, '') as PostalAddress2,
			isnull(PostalAddress3, '') as PostalAddress3, 
			isnull(PostalCity, '') as PostalCity, 
			isnull(PostalState, '') as PostalState, 
			isnull(PostalPostCode, '') as PostalPostCode, 
			isnull(PhoneWork, '') as Phone, 
			isnull(Fax, '') as  Fax,
			isnull(Email, '') as  Email,
			isnull(GSTPaidInDeduction, '') as GSTPaidInDeduction, 
			isnull(CollectFBT, '') as CollectFBT,
			isnull(NovatedLeasingType , '') as NovatedLeasingType,
			isnull(logo, '') as Logo, 
			er.employergroupid,
			er.ParentID,
			isnull(er.PartnerID, '0') as PartnerID,
			isnull(Website, '') as Website,
            isnull(abn, '0') as abn,
            isnull(acn, '0') as acn,
            isnull(AssignedTo, '') as AssignedTo,
            isnull(Address, '') as Address,
            isnull(City, '') as City,
            isnull(PostCode, '0') as PostCode,
            isnull(State, '') as State,
            isnull(Industry, '') as Industry,
            isnull(AboutCompany, '') as AboutCompany,
            ISNULL(er.Active, '') as Active,
            longitude,
            latitude,
            er.brokerid,
			er.agentid,
			er.EmployerTypeId,
			ISNULL(er.MaximumLeases, -1) as MaximumLeases,
			Cast(ISNULL(er.IsGstDeducted, 0) as bit) as IsGstDeducted,
			Cast(ISNULL(er.IsGstEquivalent, 0) as bit) as IsGstEquivalent,
			Cast(ISNULL(er.IsItcRefunded, 0) as bit) as IsItcRefunded,
			Cast(ISNULL(er.AllowLuxuryVehicle, 0) as bit) as AllowLuxuryVehicle,
			Cast(ISNULL(er.LuxuryVehicleCharged, 0) as bit) as LuxuryVehicleCharged,
			Cast(ISNULL(er.AllowOperationCost, 0) as bit) as AllowOperationCost,	
			Cast(IsNull(er.AllowExtraFields, 0) as bit) [AllowExtraFields]			
	from View_LP_Employer er
	left outer join employersext ext on ext.erid = er.erid
	where (isnull(ext.Active,0) = 1 OR @showInactive = 0)
	ORDER BY ername	
END
/****** ****************************************************************************** ******/

/****** Object:  View [dbo].[View_LP_Employer]    Script Date: 18/12/2017 3:07:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[View_LP_Employer]
AS
SELECT  er.ErId, 
		er.ErName, 
		er.ContactName, 
		er.Email, 
		er.FAX, 
		er.PhoneMobile, 
		er.PhoneWork, 
		er.PostalAddress1, 
		er.PostalAddress2, 
		er.PostalAddress3, 
		er.PostalCity, 
		er.PostalPostCode, 
		er.PostalState, 
		er.ParentID, 
		er.trustId, 
		er.employergroupid,
		er.EmployerTypeId,
		er.MaximumLeases,
		er.IsGstDeducted,
		er.IsGstEquivalent,
		er.IsItcRefunded,
		er.AllowLuxuryVehicle,
		er.LuxuryVehicleCharged,
		er.AllowOperationCost,
		er.AllowExtraFields,
		erext.PartnerID,
		erext.brokerid,
		erext.agentid,
		isnull(erext.Active,1) as Active,
		case
			when isnull(erext.Active,1) = 1 then 'Active'
			else 'Inactive'
		end as [Status],
		isnull(erext.AssignedTo,'') as [PrimaryAccountManager],
		isnull(
			stuff(
					(	
						select ', ' + link.ManagerID 
						from LP_prospectclientmanagerlink link 
						where link.erid = er.erid and link.SrcType = 2 and link.ManagerID <> isnull(erext.AssignedTo,'')
						FOR XML PATH('')
					)
				,1,2,'')
			,'') as [SecondaryAccountManagers]		
FROM    dbo.Employers er
inner join EmployersExt erext on erext.erid = er.erid
GO
/****** ****************************************************************************** ******/

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
		[IsMinisterReligion],
		[RealBaseSalary]
	From LP_Customer
	Where [ID] = @ID
/****** ****************************************************************************** ******/

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
	@isStaffSpecialist bit = NULL,
	@isMinisterReligion bit = NULL,
	@realBaseSalary decimal(18,2) = NULL,
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
		[IsClaimingTax],
		[IsStaffSpecialist],
		[IsMinisterReligion],
		[RealBaseSalary])
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
		@isClaimingTax,
		@isStaffSpecialist,
		@isMinisterReligion,
		@realBaseSalary)
	set @ID = scope_identity()
GO
/****** ****************************************************************************** ******/

/****** Object:  StoredProcedure [dbo].[sp_LP_UpdateEmployer]    Script Date: 12/12/2017 2:31:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_LP_UpdateEmployer]
	
	@erid int,
	@email nvarchar(510),
	@phone nvarchar(510),
	@fax nvarchar(510),
	@address1 nvarchar(510),
	@address2 nvarchar(510),
	@address3 nvarchar(510),
	@city nvarchar(510),
	@state nvarchar(510),
	@postcode nvarchar(510),
	@gst bit,
	@fbt bit,
	@quoting int,
	@partnerID nvarchar(200),
    @Website nvarchar(50),
	@Abn nvarchar(100),
	@Acn nvarchar(100),
	@AssignedTo nvarchar(100),
	@Address nvarchar(100),
	@CityPhis nvarchar(50),
	@PostCodePhis nvarchar(50),
	@StatePhis nvarchar(20),
	@Industry nvarchar(100),
	@ParentCompanyID int,
	@AboutCompany nvarchar(MAX),
	@longitude decimal(10,6),
	@latitude decimal(10,6),
	@status bit,
	@BrokerId int,
	@AgentId int,
	@InvoicingPartnerId int = 0,  --No longer used
	@PackagingProviderId int = 0,
	@EmployerTypeId int = NULL,
	@MaximumLeases int = NULL,
	@IsGstDeducted bit = 0,
	@IsGstEquivalent bit = 0,
	@IsItcRefunded bit = 0,
	@AllowLuxuryVehicle bit = 0,
	@LuxuryVehicleCharged bit = 0,
	@AllowOperationCost bit = 0,
	@AllowExtraFields bit = 0
AS

BEGIN
	
	begin try
	
		begin transaction
	
		update employers
		set email = @email,
			PhoneWork = @phone,
			FAX = @fax,
			PostalAddress1 = @address1,
			PostalAddress2 = @address2,
			PostalAddress3 = @address3,
			PostalCity = @city,
			PostalPostCode = @postcode,
			PostalState = @state,
			ParentID = @ParentCompanyID,
			EmployerTypeId = @EmployerTypeId,
			MaximumLeases = @MaximumLeases,
			IsGstDeducted = @IsGstDeducted,
			IsGstEquivalent = @IsGstEquivalent,
			IsItcRefunded = @IsItcRefunded,
			AllowLuxuryVehicle = @AllowLuxuryVehicle,
			LuxuryVehicleCharged = @LuxuryVehicleCharged,
			AllowOperationCost = @AllowOperationCost,
			AllowExtraFields = @AllowExtraFields
		where erid = @erid
		
		UPDATE EmployersExt
		SET GSTPaidInDeduction = @gst, 
			CollectFBT = @fbt, 
			NovatedLeasingType = @quoting,
			PartnerID = @partnerID,
			Website = @Website,
			Abn = @Abn,
			Acn = @Acn,
			AssignedTo = @AssignedTo,
			Address = @Address,
			City = @CityPhis,
			PostCode = @PostCodePhis,
			State = @StatePhis,
			Industry = @Industry,
			AboutCompany = @AboutCompany,
			longitude = @longitude,
			latitude = @latitude,
			Active = @status,
			Brokerid = @BrokerId,
			AgentId = @AgentId,
			PackagingProviderId = @PackagingProviderId
		WHERE Erid =  @erid

		commit transaction
	end try
	begin catch
		if @@trancount > 0
			rollback
	
		-- Raise an error with the details of the exception
		DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		SELECT	@ErrMsg = ERROR_MESSAGE(),
				@ErrSeverity = ERROR_SEVERITY()
		
		RAISERROR(@ErrMsg, @ErrSeverity, 1)
	end catch
END
/****** ****************************************************************************** ******/

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
	@isClaimingTax bit,
	@isStaffSpecialist bit = NULL,
	@isMinisterReligion bit = NULL,
	@realBaseSalary decimal(18,2) = NULL
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
		[IsClaimingTax] = @isClaimingTax,
		[IsStaffSpecialist] = @isStaffSpecialist,
		[IsMinisterReligion] = @isMinisterReligion,
		[RealBaseSalary] = @realBaseSalary
	Where
	ID = @iD
/****** ****************************************************************************** ******/