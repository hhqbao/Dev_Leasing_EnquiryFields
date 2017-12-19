USE [Dev_Leasing_EnquiryFields]
GO
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


