USE [Dev_Leasing_EnquiryFields]
GO

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
			,'') as [SecondaryAccountManagers],
		ISNULL(et.Name, '') as EmployerTypeName
FROM    dbo.Employers er
inner join EmployersExt erext on erext.erid = er.erid
left join LP_EmployerTypes et on er.EmployerTypeId = et.Id
GO


