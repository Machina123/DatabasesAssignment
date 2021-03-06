USE [1Ciepiela]
GO
/****** Object:  Table [dbo].[proj_tblEvent]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proj_tblEvent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[venueId] [int] NOT NULL,
	[performerId] [int] NOT NULL,
	[etime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proj_tblOrders]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proj_tblOrders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[ticketcount] [int] NULL,
	[orderDate] [datetime] NULL,
	[chksum] [binary](32) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proj_tblPerformer]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proj_tblPerformer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[performer] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proj_tblUsers]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proj_tblUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[pwd] [binary](32) NULL,
	[isadmin] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proj_tblVenue]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proj_tblVenue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vname] [nvarchar](50) NULL,
	[vaddr] [nvarchar](100) NULL,
	[vcap] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[proj_tblUsers] ADD  CONSTRAINT [DF_proj_tblUsers_isadmin]  DEFAULT ((0)) FOR [isadmin]
GO
ALTER TABLE [dbo].[proj_tblEvent]  WITH CHECK ADD FOREIGN KEY([performerId])
REFERENCES [dbo].[proj_tblPerformer] ([id])
GO
ALTER TABLE [dbo].[proj_tblEvent]  WITH CHECK ADD FOREIGN KEY([venueId])
REFERENCES [dbo].[proj_tblVenue] ([id])
GO
ALTER TABLE [dbo].[proj_tblOrders]  WITH CHECK ADD FOREIGN KEY([eventId])
REFERENCES [dbo].[proj_tblEvent] ([id])
GO
ALTER TABLE [dbo].[proj_tblOrders]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[proj_tblUsers] ([id])
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_CancelOrder]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_CancelOrder]
	@OrderId int
AS
	DELETE FROM proj_tblOrders WHERE id=@OrderId
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_CreateEvent]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_CreateEvent]
	@VenueId int,
	@PerformerId int,
	@EventTime datetime
AS
	INSERT INTO proj_tblEvent(venueId, performerId, etime) VALUES (@VenueId, @PerformerId, @EventTime)	
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_CreateOrder]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_CreateOrder]
	@EventId int,
	@UserId int,
	@TicketCount int
AS
BEGIN
	begin transaction
		Declare @OrderDate datetime
		Declare @Checksum binary(32)
		Declare @TicketsSold int
		Declare @VenueCap int
		Select @OrderDate = SYSDATETIME();
		Select @Checksum = HASHBYTES('SHA2_256', 'TicketManager-' + Convert(nvarchar(10),@EventId) + '-' + Convert(nvarchar(10),@UserId) + '-' + Convert(nvarchar(max), @OrderDate, 126));

		Select @TicketsSold = SUM(ticketcount) FROM proj_tblOrders WHERE eventId = @EventId;
		Select @VenueCap = vcap FROM proj_tblVenue WHERE proj_tblVenue.id = (SELECT venueId FROM proj_tblEvent where proj_tblEvent.id = @EventId);
	
		If(@TicketsSold + @TicketCount > @VenueCap)
		Begin
			Rollback Transaction
			RAISERROR('Selected ticket count is not available', 18, 1)
			Return
		End
		INSERT INTO proj_tblOrders(eventId, userId, ticketcount, orderDate, chksum) VALUES (@EventId, @UserId, @TicketCount, @OrderDate, @Checksum)	
	commit transaction
END
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetAllOrders]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_GetAllOrders]
AS
	SELECT proj_tblOrders.id, proj_tblUsers.username, proj_tblVenue.vname, proj_tblPerformer.performer, proj_tblEvent.etime, proj_tblOrders.ticketcount, proj_tblOrders.chksum,
	('[' + CONVERT(nvarchar(max), proj_tblOrders.orderDate, 120) + '][' + proj_tblUsers.username + '] ' + proj_tblPerformer.performer + '@' + proj_tblVenue.vname + ' ' 
		+ CONVERT(nvarchar(max), proj_tblEvent.etime, 120) + ' [' +  CONVERT(nvarchar(10), proj_tblOrders.ticketcount) + 'x]') friendlyname
	FROM proj_tblOrders
	JOIN proj_tblUsers ON proj_tblOrders.userId = proj_tblUsers.id
	JOIN proj_tblEvent on proj_tblOrders.eventId = proj_tblEvent.id
	JOIN proj_tblVenue on proj_tblEvent.venueId = proj_tblVenue.id
	JOIN proj_tblPerformer on proj_tblEvent.performerId = proj_tblPerformer.id
	ORDER BY proj_tblOrders.userId
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetEventById]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetEventById]
	@Id int
AS
	SELECT * FROM proj_tblEvent WHERE id = @Id
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetEvents]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetEvents]
AS
	SELECT proj_tblEvent.id, proj_tblEvent.etime, proj_tblPerformer.performer, proj_tblVenue.vname,
		(proj_tblPerformer.performer + ' @ ' + proj_tblVenue.vname + ' (' + CONVERT(nvarchar(max), proj_tblEvent.etime, 120) + ')') friendlyname 
	FROM proj_tblEvent
	JOIN proj_tblPerformer on  proj_tblPerformer.id = proj_tblEvent.performerId
	JOIN proj_tblVenue on proj_tblVenue.id = proj_tblEvent.venueId
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetOrdersByEvent]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_GetOrdersByEvent]
	@EventId int
AS
	SELECT proj_tblUsers.username, proj_tblUsers.email, proj_tblPerformer.performer, proj_tblOrders.ticketcount, CONVERT(nvarchar(max), proj_tblOrders.chksum, 2) orderchecksum, CONVERT(nvarchar(max), proj_tblOrders.orderDate, 120) orderdate
	FROM proj_tblOrders
	join proj_tblEvent on proj_tblEvent.id = proj_tblOrders.eventId
	join proj_tblUsers on proj_tblOrders.userId = proj_tblUsers.id
	join proj_tblPerformer on proj_tblPerformer.id = proj_tblEvent.performerId
	where proj_tblOrders.eventId = @EventId
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetOrdersByUser]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_GetOrdersByUser]
	@UserId int
AS
	SELECT proj_tblVenue.vname, proj_tblPerformer.performer, CONVERT(nvarchar(max), proj_tblEvent.etime, 120) eventtime, proj_tblOrders.ticketcount, CONVERT(nvarchar(max), proj_tblOrders.chksum, 2) orderchecksum, CONVERT(nvarchar(max), proj_tblOrders.orderDate, 120) orderdate
	FROM proj_tblOrders
	JOIN proj_tblEvent on proj_tblOrders.eventId = proj_tblEvent.id
	JOIN proj_tblVenue on proj_tblEvent.venueId = proj_tblVenue.id
	JOIN proj_tblPerformer on proj_tblEvent.performerId = proj_tblPerformer.id
	WHERE proj_tblOrders.userId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetPerformerById]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetPerformerById]
	@Id int
AS
	SELECT * FROM proj_tblPerformer WHERE id = @Id
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetPerformers]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetPerformers]
AS
	SELECT * FROM proj_tblPerformer

GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetUsers]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetUsers]
AS
	SELECT * FROM proj_tblUsers
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetVenueById]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetVenueById]
	@Id int
AS
	SELECT * FROM proj_tblVenue WHERE id = @Id
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_GetVenues]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_GetVenues]
AS
	SELECT * FROM proj_tblVenue
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_InsertPerformer]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_InsertPerformer]
	@PerformerName nvarchar(50)
AS
	INSERT INTO proj_tblPerformer (performer) VALUES (@PerformerName)	

GO
/****** Object:  StoredProcedure [dbo].[sp_proj_InsertVenue]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_InsertVenue]
	@VenueName nvarchar(50),
	@VenueAddress nvarchar(100),
	@Capacity int
AS
	INSERT INTO proj_tblVenue(vname, vaddr, vcap) VALUES (@VenueName, @VenueAddress, @Capacity)	
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_LoginUser]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_LoginUser]
	@Username nvarchar(50),
	@Password nvarchar(50),
	@LoggedInUser nvarchar(50) output,
	@UserId int output,
	@IsAdmin bit output
AS
BEGIN
	Declare @HashedPass binary(32)
	Select @HashedPass = HASHBYTES('SHA2_256', @Password)

	Select @LoggedInUser=username, @UserId=id, @IsAdmin=isadmin From proj_tblUsers Where username = @Username and pwd = @HashedPass;
	If(@@ROWCOUNT < 1)
	begin
		RAISERROR('Username or password incorrect', 18, 1)
	end

END
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_RegisterUser]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_proj_RegisterUser]
    @Username NVARCHAR(50),
    @Password NVARCHAR(100),
    @ConfirmPass NVARCHAR(100),
    @Email NVARCHAR(100),
    @IsAdmin BIT = 0
AS
BEGIN
    Begin TRY

    Declare @FoundUsers INT = 0
    Declare @HashedPassword BINARY(32)

    IF(@Password != @ConfirmPass)
    BEGIN
        RAISERROR('Passwords do not match!', 16, 1)
    END

    SELECT @FoundUsers = Count(1) FROM proj_tblUsers WHERE username = @Username OR email = @Email;
    If(@FoundUsers > 0)
    BEGIN
        RAISERROR('User already registered!', 16, 1)
    END
	
	select @HashedPassword = HASHBYTES('SHA2_256', @Password)

	begin transaction
	
	insert into proj_tblUsers(username, email, pwd) values (@Username, @Email, @HashedPassword)

	commit transaction

    end TRY
    BEGIN CATCH
		if(@@TRANCOUNT > 0) rollback transaction;
        execute spShowError;
    end CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_RemoveEvent]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_RemoveEvent]
	@EventId int
AS
Begin
	Declare @OrdersForEvent int
	Select @OrdersForEvent = COUNT(1) FROM proj_tblOrders WHERE eventId = @EventId
	If(@OrdersForEvent > 0)
	Begin
		RAISERROR('Cannot delete event when orders for this event are created.', 18, 1)
		return
	End
	DELETE FROM proj_tblEvent where id=@EventId
End
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_RemovePerformer]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_RemovePerformer]
	@PerformerId int
AS
BEGIN
	Declare @PerformerEvents int
	Select @PerformerEvents = COUNT(1) FROM proj_tblEvent WHERE performerId = @PerformerId

	If(@PerformerEvents > 0)
	Begin
		RAISERROR('Cannot remove selected performer, there are events associated with it.', 18, 1)
		return
	End

	DELETE FROM proj_tblPerformer WHERE id = @PerformerId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_proj_RemoveVenue]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_proj_RemoveVenue]
	@VenueId int
AS
BEGIN
	Declare @EventsAtVenue int
	Select @EventsAtVenue = COUNT(1) FROM proj_tblEvent WHERE venueId = @VenueId

	If(@EventsAtVenue > 0)
	Begin
		RAISERROR('Cannot remove selected venue, there are events associated with it.', 18, 1)
		return
	End

	DELETE FROM proj_tblVenue WHERE id = @VenueId
END
GO
/****** Object:  StoredProcedure [dbo].[spShowError]    Script Date: 21.01.2020 00:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROcedure [dbo].[spShowError] AS
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;
GO
