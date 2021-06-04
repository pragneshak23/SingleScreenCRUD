/****  Create table ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[Designation] [varchar](250) NULL,
	[Skills] [varchar](100) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/**** Store Procedure for ContactCreateOrUpdate ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactCreateOrUpdate]
@ConatctID int,
@Name varchar(50),
@DateOfBirth varchar(50),
@Designation varchar(250),
@Skills varchar(100)
AS
BEGIN
IF(@ConatctID=0)
	BEGIN
	INSERT INTO Contact(Name,DateOfBirth,Designation,Skills)
	VALUES(@Name,@DateOfBirth,@Designation,@Skills)
	END
ELSE
	BEGIN
	UPDATE Contact
	SET
		Name = @Name,
		DateOfBirth = @DateOfBirth,
		Designation = @Designation,
        Skills = @Skills
	WHERE ContactID= @ConatctID
	END

END
GO
/**** Store Procedure for ContactDeleteByID ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactDeleteByID]
@ContactID int
AS
	BEGIN
	DELETE FROM Contact
	WHERE ContactID = @ContactID
	END

GO

/**** Store Procedure for ContactViewAll ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactViewAll]
AS
	BEGIN
	SELECT *
	FROM Contact
	END

GO

/**** Store Procedure for ContactViewAll ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactViewByID]
@ContactID int
As
	BEGIN
	SELECT *
	FROm Contact
	WHERE ContactID = @ContactID
	END


GO
