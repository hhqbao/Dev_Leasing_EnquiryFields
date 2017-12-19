USE [Dev_Leasing_EnquiryFields]
GO
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
	@AllowOperationCost bit = 0
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
			AllowOperationCost = @AllowOperationCost
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

