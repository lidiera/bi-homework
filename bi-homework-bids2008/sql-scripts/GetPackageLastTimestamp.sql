-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GetPackageLastTimestamp 
	-- Add the parameters for the stored procedure here
	@PackageName nvarchar(50) = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @LastTimestamp AS datetime = NULL

    -- Insert statements for procedure here
	SET @LastTimestamp = 
	SELECT TOP 1
		LastTimestamp
	FROM 
		PackageTimestamps
	WHERE PackageName = @PackageName



END
GO
