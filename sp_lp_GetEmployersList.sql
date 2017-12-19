USE [Dev_Leasing_EnquiryFields]
GO
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
			er.EmployerTypeName
	from View_LP_Employer er
	left outer join employersext ext on ext.erid = er.erid
	where (isnull(ext.Active,0) = 1 OR @showInactive = 0)
	ORDER BY ername
	
END

