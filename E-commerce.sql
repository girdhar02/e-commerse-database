USE [master]
GO
/****** Object:  Database [E-commerce]    Script Date: 23-Mar-21 3:22:31 PM ******/
CREATE DATABASE [E-commerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'E-commerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\E-commerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'E-commerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\E-commerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [E-commerce] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [E-commerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [E-commerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [E-commerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [E-commerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [E-commerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [E-commerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [E-commerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [E-commerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [E-commerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [E-commerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [E-commerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [E-commerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [E-commerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [E-commerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [E-commerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [E-commerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [E-commerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [E-commerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [E-commerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [E-commerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [E-commerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [E-commerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [E-commerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [E-commerce] SET RECOVERY FULL 
GO
ALTER DATABASE [E-commerce] SET  MULTI_USER 
GO
ALTER DATABASE [E-commerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [E-commerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [E-commerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [E-commerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [E-commerce] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [E-commerce] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'E-commerce', N'ON'
GO
ALTER DATABASE [E-commerce] SET QUERY_STORE = OFF
GO
USE [E-commerce]
GO
/****** Object:  UserDefinedFunction [dbo].[filter_item_num_cost]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION  [dbo].[filter_item_num_cost]
(
    @min int,
	@max int
)
RETURNS INT
AS
BEGIN
 return (select count(*) from product where price between @min and @max)
END
GO
/****** Object:  Table [dbo].[cart]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [int] NOT NULL,
	[cart_no] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[product_name] [varchar](20) NULL,
	[product_id] [varchar](20) NULL,
	[sku] [varchar](20) NULL,
	[price] [smallmoney] NULL,
	[quantity] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[catergory_id] [int] NOT NULL,
	[category_name] [varchar](20) NULL,
	[description] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[catergory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[Customer_Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](40) NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Billing_Address] [varchar](40) NOT NULL,
	[Default_address] [varchar](40) NULL,
	[Country] [varchar](20) NOT NULL,
	[password_user] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_confirmation]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_confirmation](
	[order_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[order_date_time] [datetime] NOT NULL,
	[ship_date] [date] NOT NULL,
	[ship_address] [varchar](20) NOT NULL,
	[billing_address] [varchar](20) NOT NULL,
	[total_bill] [smallmoney] NULL,
	[transaction_number] [int] NULL,
	[payment_mode] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[order_id] [int] IDENTITY(100000,1) NOT NULL,
	[order_number] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[price] [smallmoney] NOT NULL,
	[quantity] [int] NOT NULL,
	[sku] [varchar](20) NOT NULL,
	[cart_id] [int] NOT NULL,
	[total] [smallmoney] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] NOT NULL,
	[sku] [varchar](20) NOT NULL,
	[product_name] [varchar](20) NOT NULL,
	[price] [smallmoney] NULL,
	[Description_p] [varchar](20) NULL,
	[image] [varchar](20) NULL,
	[stock] [int] NOT NULL,
	[catergory_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_customer_id] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[customer] ([Customer_Id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_customer_id]
GO
ALTER TABLE [dbo].[order_confirmation]  WITH CHECK ADD  CONSTRAINT [fk_customer_id_oc] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([Customer_Id])
GO
ALTER TABLE [dbo].[order_confirmation] CHECK CONSTRAINT [fk_customer_id_oc]
GO
ALTER TABLE [dbo].[order_confirmation]  WITH CHECK ADD  CONSTRAINT [fk_order_id_od] FOREIGN KEY([order_id])
REFERENCES [dbo].[order_detail] ([order_id])
GO
ALTER TABLE [dbo].[order_confirmation] CHECK CONSTRAINT [fk_order_id_od]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [fk_cart_no_od] FOREIGN KEY([cart_id])
REFERENCES [dbo].[cart] ([id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [fk_cart_no_od]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [fk_customer_id_od] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([Customer_Id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [fk_customer_id_od]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [fk_product_id_od] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [fk_product_id_od]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [fk_catergory_id] FOREIGN KEY([catergory_id])
REFERENCES [dbo].[category] ([catergory_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [fk_catergory_id]
GO
/****** Object:  StoredProcedure [dbo].[delete_cart_item]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_cart_item](@user_id int, @product_id int) as
begin
  delete  from cart where (product_id=@product_id and Customer_Id= @user_id);
end
GO
/****** Object:  StoredProcedure [dbo].[discountItem]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[discountItem] (@product_id int , @discount int) as
begin 
if exists (select * from cart where product_id = @product_id )
begin 
 Update cart
 Set price = price - price * @discount /100 
 where product_id = @product_id
 end 
 else 
 begin 
  select * from Cart
  end
end
GO
/****** Object:  StoredProcedure [dbo].[filter_item_cost]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[filter_item_cost](@min int, @max int) as
begin
	 select product_name, price,Description_p,[image] from product where price between @min and @max;
end
GO
/****** Object:  StoredProcedure [dbo].[findCust]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[findCust](@Customer_Id int) as
begin
   select * from customer where Customer_Id=@Customer_Id;
end
GO
/****** Object:  StoredProcedure [dbo].[findOrder]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[findOrder] (@order_id int) as
begin
if exists (select * from order_confirmation where order_id = @order_id )
begin
	 select * from order_confirmation where order_id = @order_id
end
else
	begin
		print('No order');
	end
end
GO
/****** Object:  StoredProcedure [dbo].[showItem]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[showItem] (@id int ) as
begin 
	select * from cart where product_id = @id
end 
GO
/****** Object:  StoredProcedure [dbo].[view_cart_items]    Script Date: 23-Mar-21 3:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[view_cart_items](@user_id int) as  
begin 
	select cart.product_name, cart.product_id, cart.price,cart.quantity 
	from cart join
	product on cart.product_id=product.product_id
	where  cart.Customer_Id=@user_id
end 
GO
USE [master]
GO
ALTER DATABASE [E-commerce] SET  READ_WRITE 
GO
