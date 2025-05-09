USE [master]
GO
CREATE DATABASE [OnlineBookstore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineBookstore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineBookstore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineBookstore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineBookstore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OnlineBookstore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [OnlineBookstore].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO
ALTER DATABASE [OnlineBookstore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineBookstore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineBookstore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineBookstore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineBookstore] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineBookstore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineBookstore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineBookstore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineBookstore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineBookstore] SET CURSOR_DEFAULT GLOBAL 
GO
ALTER DATABASE [OnlineBookstore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineBookstore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineBookstore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineBookstore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineBookstore] SET DISABLE_BROKER 
GO
ALTER DATABASE [OnlineBookstore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineBookstore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineBookstore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineBookstore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineBookstore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineBookstore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineBookstore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineBookstore] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineBookstore] SET MULTI_USER 
GO
ALTER DATABASE [OnlineBookstore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineBookstore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineBookstore] SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF) 
GO
ALTER DATABASE [OnlineBookstore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineBookstore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineBookstore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineBookstore', N'ON'
GO
ALTER DATABASE [OnlineBookstore] SET QUERY_STORE = ON
GO
ALTER DATABASE [OnlineBookstore] SET QUERY_STORE (
    OPERATION_MODE = READ_WRITE, 
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), 
    DATA_FLUSH_INTERVAL_SECONDS = 900, 
    INTERVAL_LENGTH_MINUTES = 60, 
    MAX_STORAGE_SIZE_MB = 1000, 
    QUERY_CAPTURE_MODE = AUTO, 
    SIZE_BASED_CLEANUP_MODE = AUTO, 
    MAX_PLANS_PER_QUERY = 200, 
    WAIT_STATS_CAPTURE_MODE = ON
)
GO

USE [OnlineBookstore]
GO

-- Table: Author
CREATE TABLE [dbo].[Author](
	[author_id] [int] IDENTITY(1,1) NOT NULL,
	  NOT NULL,
PRIMARY KEY CLUSTERED ([author_id] ASC)
) ON [PRIMARY]
GO

-- Table: Book
CREATE TABLE [dbo].[Book](
	[book_id] [int] IDENTITY(1,1) NOT NULL,
	  NOT NULL,
	[category_id] [int] NULL,
PRIMARY KEY CLUSTERED ([book_id] ASC)
) ON [PRIMARY]
GO

-- Table: BookAuthor
CREATE TABLE [dbo].[BookAuthor](
	[book_id] [int] NOT NULL,
	[author_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED ([book_id] ASC, [author_id] ASC)
) ON [PRIMARY]
GO

-- Table: Category
CREATE TABLE [dbo].[Category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	  NOT NULL,
PRIMARY KEY CLUSTERED ([category_id] ASC)
) ON [PRIMARY]
GO

-- Table: Customer
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	  NOT NULL,
	  NOT NULL,
PRIMARY KEY CLUSTERED ([customer_id] ASC),
UNIQUE NONCLUSTERED ([email] ASC)
) ON [PRIMARY]
GO

-- Table: Order
CREATE TABLE [dbo].[Order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([order_id] ASC)
) ON [PRIMARY]
GO

-- Table: OrderItem
CREATE TABLE [dbo].[OrderItem](
	[order_item_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[book_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED ([order_item_id] ASC)
) ON [PRIMARY]
GO

-- Foreign Keys
ALTER TABLE [dbo].[Book] ADD FOREIGN KEY([category_id]) REFERENCES [dbo].[Category]([category_id]);
ALTER TABLE [dbo].[BookAuthor] ADD FOREIGN KEY([author_id]) REFERENCES [dbo].[Author]([author_id]);
ALTER TABLE [dbo].[BookAuthor] ADD FOREIGN KEY([book_id]) REFERENCES [dbo].[Book]([book_id]);
ALTER TABLE [dbo].[Order] ADD FOREIGN KEY([customer_id]) REFERENCES [dbo].[Customer]([customer_id]);
ALTER TABLE [dbo].[OrderItem] ADD FOREIGN KEY([book_id]) REFERENCES [dbo].[Book]([book_id]);
ALTER TABLE [dbo].[OrderItem] ADD FOREIGN KEY([order_id]) REFERENCES [dbo].[Order]([order_id]);
GO

-- Indexes
CREATE NONCLUSTERED INDEX IX_Book_CategoryId ON dbo.Book(category_id);
GO
CREATE NONCLUSTERED INDEX IX_BookAuthor_AuthorId ON dbo.BookAuthor(author_id);
GO
CREATE NONCLUSTERED INDEX IX_Order_CustomerId ON dbo.[Order](customer_id);
GO
CREATE NONCLUSTERED INDEX IX_OrderItem_OrderId ON dbo.OrderItem(order_id);
GO
CREATE NONCLUSTERED INDEX IX_OrderItem_BookId ON dbo.OrderItem(book_id);
GO
CREATE NONCLUSTERED INDEX IX_Customer_Name ON dbo.Customer(name);
GO
CREATE NONCLUSTERED INDEX IX_Book_Title ON dbo.Book(title);
GO

USE [master]
GO
ALTER DATABASE [OnlineBookstore] SET READ_WRITE 
GO
