USE [master]
GO
/****** Object:  Database [ReactSneakers]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE DATABASE [ReactSneakers]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ReactSneakers', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReactSneakers.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ReactSneakers_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReactSneakers_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ReactSneakers] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ReactSneakers].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ReactSneakers] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ReactSneakers] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ReactSneakers] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ReactSneakers] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ReactSneakers] SET ARITHABORT OFF 
GO
ALTER DATABASE [ReactSneakers] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ReactSneakers] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ReactSneakers] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ReactSneakers] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ReactSneakers] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ReactSneakers] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ReactSneakers] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ReactSneakers] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ReactSneakers] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ReactSneakers] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ReactSneakers] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ReactSneakers] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ReactSneakers] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ReactSneakers] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ReactSneakers] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ReactSneakers] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ReactSneakers] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ReactSneakers] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ReactSneakers] SET  MULTI_USER 
GO
ALTER DATABASE [ReactSneakers] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ReactSneakers] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ReactSneakers] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ReactSneakers] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ReactSneakers] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ReactSneakers] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ReactSneakers] SET QUERY_STORE = OFF
GO
USE [ReactSneakers]
GO
/****** Object:  Schema [HangFire]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[Sneaker]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sneaker](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Price] [nvarchar](50) NULL,
	[Img] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sneaker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](200) NOT NULL,
	[Role] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CX_HangFire_Counter]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE CLUSTERED INDEX [CX_HangFire_Counter] ON [HangFire].[Counter]
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 03/22/2023 9:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Sneaker] ON 

INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (11, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (12, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (13, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (14, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (15, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (16, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (17, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (18, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (19, N'примпвапер', N'222', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (20, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (21, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (22, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (23, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (24, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (25, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (26, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (28, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (29, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (30, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (31, N'пвапвап', N'44', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (32, N'пвапва', N'4434', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (33, N'пвапва', N'4434', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (34, N'пвапва', N'4434', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (35, N'пвапва', N'5', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (36, N'пвапва', N'54', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (37, N'пвапва', N'545', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (38, N'пвапва', N'5454', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (39, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (40, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (41, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (42, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (43, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (44, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (45, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (46, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (47, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (48, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (49, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (50, N'пвапва', N'54544', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (51, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (52, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (53, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (54, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (55, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
INSERT [dbo].[Sneaker] ([Id], [Title], [Price], [Img]) VALUES (56, N'папап', N'4', N'/react-sneakers/img/sneakers/4.jpg')
SET IDENTITY_INSERT [dbo].[Sneaker] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Login], [Password], [Role]) VALUES (1, N'admin', N'80572e29757cbc5744d4beffbaf38037ec31351dae3f5833285c11799dcdfc69', N'Admin')
INSERT [dbo].[User] ([Id], [Login], [Password], [Role]) VALUES (2, N'levan', N'823cba594d80e71e83d8826d211db37b5a79ab56648ee287ef0575de79363c44', N'user')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 129, NULL)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-03-11', 123, CAST(N'2023-04-11T22:22:20.550' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-03-12', 6, CAST(N'2023-04-12T07:54:53.270' AS DateTime))
GO
INSERT [HangFire].[Schema] ([Version]) VALUES (7)
GO
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'hirutsu:18324:79d69d38-b3ef-443d-ad04-9d422cee6097', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2023-03-22T17:03:17.3502656Z"}', CAST(N'2023-03-22T17:21:47.913' AS DateTime))
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 03/22/2023 9:21:53 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
USE [master]
GO
ALTER DATABASE [ReactSneakers] SET  READ_WRITE 
GO
