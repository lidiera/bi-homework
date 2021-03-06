/****** Object:  Database [bi-homework]    Script Date: 7/31/2018 12:03:44 AM ******/
CREATE DATABASE [bi-homework]
GO
USE [bi-homework]
GO
/****** Object:  Table [dbo].[ETLAudit]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETLAudit](
	[ETLAuditPK] [int] IDENTITY(1,1) NOT NULL,
	[ExecutedPackage] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[ExecutionStatus] [smallint] NOT NULL,
	[ErrorTime] [datetime] NULL,
	[ErrorSource] [varchar](100) NULL,
	[ErrorSourceDescription] [varchar](100) NULL,
	[ErrorCode] [varchar](50) NULL,
	[ErrorDescription] [varchar](1000) NULL,
	[MachineName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[ExecutionInstanceGUID] [varchar](50) NOT NULL,
	[ExtractedRows] [int] NOT NULL,
	[InsertedRows] [int] NOT NULL,
	[UpdatedRows] [int] NOT NULL,
	[NullRows] [int] NOT NULL,
	[FailedRows] [int] NOT NULL,
 CONSTRAINT [PK_ETLAudit] PRIMARY KEY CLUSTERED 
(
	[ETLAuditPK] ASC
)
)
GO
/****** Object:  Table [dbo].[Source_DataIn_Account]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Source_DataIn_Account](
	[Account No] [nvarchar](255) NOT NULL,
	[Account Status] [nvarchar](255) NULL,
	[Account Open Date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Account No] ASC
)
)
GO
/****** Object:  Table [dbo].[Source_DataIn_Transaction]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Source_DataIn_Transaction](
	[Transaction ID] [nvarchar](255) NOT NULL,
	[Transaction Date] [datetime] NULL,
	[Transaction Amount] [money] NULL,
	[Account No] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Transaction ID] ASC
)
)
GO
/****** Object:  Table [dbo].[TEMP_Source_DataIn_Account]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMP_Source_DataIn_Account](
	[Account No] [nvarchar](255) NOT NULL,
	[Account Status] [nvarchar](255) NULL,
	[Account Open Date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Account No] ASC
)
)
GO
/****** Object:  Table [dbo].[TEMP_Source_DataIn_Transaction]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMP_Source_DataIn_Transaction](
	[Transaction ID] [nvarchar](255) NOT NULL,
	[Transaction Date] [datetime] NULL,
	[Transaction Amount] [money] NULL,
	[Account No] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Transaction ID] ASC
)
)
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_StartTime]  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_ExecutionStatus]  DEFAULT ((1)) FOR [ExecutionStatus]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_RowsTransfered]  DEFAULT ((0)) FOR [ExtractedRows]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_RowsInserted]  DEFAULT ((0)) FOR [InsertedRows]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_RowsUpdated]  DEFAULT ((0)) FOR [UpdatedRows]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_NullRows]  DEFAULT ((0)) FOR [NullRows]
GO
ALTER TABLE [dbo].[ETLAudit] ADD  CONSTRAINT [DF_ETLAudit_FailedRows]  DEFAULT ((0)) FOR [FailedRows]
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageEnd]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sProc_ETLAudit_PackageEnd] 
	@ETLAuditPK int,
	@ETLAuditExtractedRows int = 0,
	@ETLAuditInsertedRows int = 0,
	@ETLAuditUpdatedRows int = 0,
	@ETLAuditNullRows int = 0,
	@ETLAuditFailedRows int = 0
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE dbo.ETLAudit
		SET ExecutionStatus = 0,
		EndTime = GETDATE(),
		ExtractedRows = @ETLAuditExtractedRows,
		InsertedRows = @ETLAuditInsertedRows,
		UpdatedRows = @ETLAuditUpdatedRows,
		NullRows = @ETLAuditNullRows,
		FailedRows = @ETLAuditFailedRows
	WHERE ETLAuditPK = @ETLAuditPK
END
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageError]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sProc_ETLAudit_PackageError]
	@ETLAuditPK int,
	@ETLAuditErrorSource varchar(100),
	@ETLAuditErrorSourceDescription varchar(100),
	@ETLAuditErrorCode varchar(50),
	@ETLAuditErrorDescription varchar(1000),
	@ETLAuditExtractedRows int = 0,
	@ETLAuditInsertedRows int = 0,
	@ETLAuditUpdatedRows int = 0,
	@ETLAuditNullRows int = 0,
	@ETLAuditFailedRows int = 0
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.ETLAudit
		SET ExecutionStatus = -1,
		ErrorTime = GETDATE(),
		ErrorSource = @ETLAuditErrorSource,
		ErrorSourceDescription = @ETLAuditErrorSourceDescription,
		ErrorCode = @ETLAuditErrorCode,
		ErrorDescription = @ETLAuditErrorDescription,
		ExtractedRows = @ETLAuditExtractedRows,
		InsertedRows = @ETLAuditInsertedRows,
		UpdatedRows = @ETLAuditUpdatedRows,
		NullRows = @ETLAuditNullRows,
		FailedRows = @ETLAuditFailedRows
	WHERE ETLAuditPK = @ETLAuditPK
END
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageStart]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sProc_ETLAudit_PackageStart] 
	@PackageName varchar(50),
	@ExecutionInstanceGUID varchar(50),
	@MachineName varchar(50),
	@UserName varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.ETLAudit (ExecutedPackage, ExecutionInstanceGUID, MachineName, UserName) 
	VALUES (@PackageName, @ExecutionInstanceGUID, @MachineName, @UserName)

	RETURN CAST(@@IDENTITY AS INT)
END
GO
/****** Object:  StoredProcedure [dbo].[sProc_UpsertMerge]    Script Date: 7/31/2018 12:03:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sProc_UpsertMerge]
	@PackageName varchar(50) = NULL, 
	@TablePK varchar(50) = NULL,
	@ETLAuditInsertedRows int = NULL OUTPUT,
	@ETLAuditUpdatedRows int = NULL OUTPUT
	
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SourceTable nvarchar(50) = 'TEMP_' + @PackageName
	DECLARE @PrimaryKeyColumn nvarchar(50) = @TablePK
	DECLARE @DestinationTable nvarchar(50) = @PackageName 

	---------------------------------------------------------------------------
	-- Detect all table columns except primary key
	---------------------------------------------------------------------------
	DECLARE @ColumnsString AS nvarchar(1000);
	
	WITH column_names AS (
		SELECT 
			column_name 
		FROM [information_schema].[columns] 
		WHERE table_name = @DestinationTable
		AND column_name <> SUBSTRING(@PrimaryKeyColumn, 2,(LEN(@PrimaryKeyColumn) -2))
	),
	column_names_subresult AS (
		SELECT TOP 1 
			SUBSTRING(
				(
				SELECT ',['+ column_names.column_name  + ']' AS [text()]
				FROM column_names
				FOR XML PATH ('')
				)
			, 2, 1000) AS [columns]
		FROM column_names)
	SELECT @ColumnsString = [columns] FROM column_names_subresult
	--PRINT (@ColumnsString)

	---------------------------------------------------------------------------
	-- Insert new rows
	---------------------------------------------------------------------------

	DECLARE @SQL VARCHAR(MAX);

	SET @SQL = '
	INSERT ' + @DestinationTable + ' (' + @PrimaryKeyColumn + ',' +  @ColumnsString + ')  
	SELECT ' + @PrimaryKeyColumn + ',' + @ColumnsString + '   
	FROM ' + @SourceTable + ' AS SourceTable  
	WHERE NOT EXISTS (
		SELECT ' + @PrimaryKeyColumn + '
		FROM ' + @DestinationTable + ' AS DestinationTable
		WHERE DestinationTable.' + @PrimaryKeyColumn + '= SourceTable.' + @PrimaryKeyColumn + '
	)'
	
	--PRINT(@SQL);
	EXEC(@SQL);
	SET @ETLAuditInsertedRows = @@ROWCOUNT
	---------------------------------------------------------------------------
	-- Update existing rows
	---------------------------------------------------------------------------
	DECLARE @CursorColumnName AS nvarchar(50)
	DECLARE Columns_Cursor CURSOR FOR 
    SELECT '[' + column_name + ']'
	FROM [information_schema].[columns] 
	WHERE table_name = @DestinationTable
	AND column_name <> SUBSTRING(@PrimaryKeyColumn, 2,(LEN(@PrimaryKeyColumn) -2))

	CREATE TABLE #UpdatedPKList (PK nvarchar(255))

	OPEN Columns_Cursor 
	FETCH NEXT FROM Columns_Cursor INTO @CursorColumnName 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @SQL = '
			UPDATE ' + @DestinationTable + '
			SET ' + @CursorColumnName + ' = [Source].' + @CursorColumnName + '
			OUTPUT [Source].' + @PrimaryKeyColumn + ' INTO #UpdatedPKList
			FROM ' + @DestinationTable + ' AS [Destination]
			INNER JOIN ' + @SourceTable + ' AS [Source]
			ON [Destination].' + @PrimaryKeyColumn + ' = [Source].' + @PrimaryKeyColumn + '
			AND [Destination].' + @CursorColumnName + ' <> [Source].' + @CursorColumnName
		--PRINT(@SQL);
		EXEC(@SQL);
		FETCH NEXT FROM Columns_Cursor INTO @CursorColumnName
	END
	CLOSE Columns_Cursor
	DEALLOCATE Columns_Cursor

	SET @ETLAuditUpdatedRows = (SELECT COUNT(DISTINCT PK) FROM #UpdatedPKList)
	DROP TABLE #UpdatedPKList
END
GO
USE [master]
GO
ALTER DATABASE [bi-homework] SET  READ_WRITE 
GO
