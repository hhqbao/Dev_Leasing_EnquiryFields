Use Dev_Leasing_EnquiryFields

Begin transaction

ALTER TABLE Employers ADD EmployerTypeId int
ALTER TABLE Employers ADD MaximumLeases smallint
ALTER TABLE Employers ADD IsGstDeducted bit
ALTER TABLE Employers ADD IsGstEquivalent bit
ALTER TABLE Employers ADD IsItcRefunded bit
ALTER TABLE Employers ADD AllowLuxuryVehicle bit
ALTER TABLE Employers ADD LuxuryVehicleCharged bit
ALTER TABLE Employers ADD AllowOperationCost bit

/****** Object:  Table [dbo].[LP_EmployerTypes]    Script Date: 12/12/2017 10:43:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LP_EmployerTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](80) NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_LP_EmployerTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Employers]  WITH CHECK ADD  CONSTRAINT [FK_Employer_EmployerType] FOREIGN KEY([EmployerTypeId])
REFERENCES [dbo].[LP_EmployerTypes] ([Id])

/****** Create new fields for table LP_Customer ******/
ALTER TABLE LP_Customer ADD HasHECSDebt bit
ALTER TABLE LP_Customer ADD IsClaimingTax bit

Rollback transaction