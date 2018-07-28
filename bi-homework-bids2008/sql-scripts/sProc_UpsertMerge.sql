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
ALTER PROCEDURE sProc_UpsertMerge
	-- Add the parameters for the stored procedure here
	@SourceTable nvarchar(50) = NULL, 
	@PrimaryKeyColumn nvarchar(50) = NULL,
	@DestinationTable nvarchar(50) = NULL 
	--@SourceTable nvarchar(50) = 'TEMP_Source_DataIn_Account', 
	--@PrimaryKeyColumn nvarchar(50) = '[Account No]',
	--@DestinationTable nvarchar(50) = 'Source_DataIn_Account' 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here

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
	PRINT (@ColumnsString)

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
	
	PRINT(@SQL);
	EXEC(@SQL);

	---------------------------------------------------------------------------
	-- Update existing rows
	---------------------------------------------------------------------------
	DECLARE @CursorColumnName AS nvarchar(50)
	DECLARE Columns_Cursor CURSOR FOR 
    SELECT '[' + column_name + ']'
	FROM [information_schema].[columns] 
	WHERE table_name = @DestinationTable
	AND column_name <> SUBSTRING(@PrimaryKeyColumn, 2,(LEN(@PrimaryKeyColumn) -2))

	OPEN Columns_Cursor 
	FETCH NEXT FROM Columns_Cursor INTO @CursorColumnName 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @SQL = '
			UPDATE ' + @DestinationTable + '
			SET ' + @CursorColumnName + ' = [Source].' + @CursorColumnName + '
			FROM ' + @DestinationTable + ' AS [Destination]
			INNER JOIN ' + @SourceTable + ' AS [Source]
			ON [Destination].' + @PrimaryKeyColumn + ' = [Source].' + @PrimaryKeyColumn + '
			AND [Destination].' + @CursorColumnName + ' <> [Source].' + @CursorColumnName
		PRINT(@SQL);
		EXEC(@SQL);
		FETCH NEXT FROM Columns_Cursor INTO @CursorColumnName
	END
	CLOSE Columns_Cursor
	DEALLOCATE Columns_Cursor

	---------------------------------------------------------------------------
	-- Final tasks
	---------------------------------------------------------------------------

	SET @SQL = 'SELECT * FROM ' + @DestinationTable
	PRINT(@SQL)
	EXEC(@SQL)

	--SET @SQL = '
	--INSERT ' + @DestinationTable + ' (' + @PrimaryKeyColumn + ',' +  @ColumnsString + ')  
	--SELECT ' + @PrimaryKeyColumn + ',' + @ColumnsString + '   
	--FROM ' + @SourceTable + ' AS SourceTable  
	--WHERE NOT EXISTS (
	--	SELECT ' + @PrimaryKeyColumn + '
	--	FROM ' + @DestinationTable + ' AS DestinationTable
	--	WHERE DestinationTable.' + @PrimaryKeyColumn + '= SourceTable.' + @PrimaryKeyColumn + '
	--)'

	--SET @SQL = '
	--MERGE INTO ' + @DestinationTable + '  AS DestinationTable  
 --   USING ' + @SourceTable + '  
 --   ON  DestinationTable.' + + '
 --   [ WHEN MATCHED [ AND <clause_search_condition> ]  
 --       THEN <merge_matched> ] [ ...n ]  
 --   [ WHEN NOT MATCHED [ BY TARGET ] [ AND <clause_search_condition> ]  
 --       THEN <merge_not_matched> ]  
 --   [ WHEN NOT MATCHED BY SOURCE [ AND <clause_search_condition> ]  
 --       THEN <merge_matched> ] [ ...n ]  
 --   [ <output_clause> ]  
 --   [ OPTION ( <query_hint> [ ,...n ] ) ]  
--	' 
	
	
END
GO
