USE [master]
GO
/****** Object:  Database [bi-homework]    Script Date: 7/31/2018 12:03:44 AM ******/
CREATE DATABASE [bi-homework] ON  PRIMARY 
( NAME = N'bi-homework', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\bi-homework.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bi-homework_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\bi-homework_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bi-homework] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bi-homework].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bi-homework] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bi-homework] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bi-homework] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bi-homework] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bi-homework] SET ARITHABORT OFF 
GO
ALTER DATABASE [bi-homework] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [bi-homework] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bi-homework] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bi-homework] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bi-homework] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bi-homework] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bi-homework] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bi-homework] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bi-homework] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bi-homework] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bi-homework] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bi-homework] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bi-homework] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bi-homework] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bi-homework] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bi-homework] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bi-homework] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bi-homework] SET RECOVERY FULL 
GO
ALTER DATABASE [bi-homework] SET  MULTI_USER 
GO
ALTER DATABASE [bi-homework] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bi-homework] SET DB_CHAINING OFF 
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
