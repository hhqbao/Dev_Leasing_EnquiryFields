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