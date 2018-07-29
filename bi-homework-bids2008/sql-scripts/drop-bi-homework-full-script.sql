USE [bi-homework]
GO
/****** Object:  StoredProcedure [dbo].[sProc_UpsertMerge]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP PROCEDURE [dbo].[sProc_UpsertMerge]
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageStart]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP PROCEDURE [dbo].[sProc_ETLAudit_PackageStart]
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageError]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP PROCEDURE [dbo].[sProc_ETLAudit_PackageError]
GO
/****** Object:  StoredProcedure [dbo].[sProc_ETLAudit_PackageEnd]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP PROCEDURE [dbo].[sProc_ETLAudit_PackageEnd]
GO
/****** Object:  Table [dbo].[TEMP_Source_DataIn_Transaction]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[TEMP_Source_DataIn_Transaction]
GO
/****** Object:  Table [dbo].[TEMP_Source_DataIn_Account]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[TEMP_Source_DataIn_Account]
GO
/****** Object:  Table [dbo].[Source_DataIn_Transaction]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[Source_DataIn_Transaction]
GO
/****** Object:  Table [dbo].[Source_DataIn_Account]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[Source_DataIn_Account]
GO
/****** Object:  Table [dbo].[PackageTimestamps]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[PackageTimestamps]
GO
/****** Object:  Table [dbo].[ETLAudit]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP TABLE [dbo].[ETLAudit]
GO
USE [master]
GO
/****** Object:  Database [bi-homework]    Script Date: 7/29/2018 4:49:15 AM ******/
DROP DATABASE [bi-homework]
GO
