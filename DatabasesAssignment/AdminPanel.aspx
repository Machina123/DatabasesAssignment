<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="DatabasesAssignment.AdminPanel" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <div class="row" runat="server" visible="false" id="successContainer">
        <div class="col-sm-12">
            <div id="successAlert" class="alert alert-success" runat="server"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <h2>Add new performer</h2>
            <p>
                <label for="perfName">Performer name:</label>
                <asp:TextBox ID="perfName" TextMode="SingleLine" MaxLength="50" runat="server" CssClass="form-control" />
                <asp:Button ID="btnAddPerformer" runat="server" CssClass="btn btn-success" OnClick="btnAddPerformer_Click" Text="Add performer" />
            </p>
        </div>
        <hr />
        <div class="col-sm-12">
            <h2>Add new venue</h2>
            <p>
                <label for="venueName">Venue name:</label>
                <asp:TextBox ID="venueName" TextMode="SingleLine" MaxLength="50" runat="server" CssClass="form-control" />
                <label for="venueAddr">Venue Address</label>
                <asp:TextBox ID="venueAddr" TextMode="SingleLine" MaxLength="100" runat="server" CssClass="form-control" />
                <label for="venueCap">Venue capacity:</label>
                <asp:TextBox ID="venueCap" TextMode="Number" runat="server" CssClass="form-control" />
                <asp:Button ID="btnAddVenue" runat="server" CssClass="btn btn-success" Text="Add venue" OnClick="btnAddVenue_Click" />
            </p>
        </div>
        <div class="col-sm-12">
            <h2>Create event</h2>
            <p>
                <label for="eventPerf">Performer:</label>
                <select runat="server" id="eventPerf" class="form-control"></select>
                <label for="eventVenue">Venue:</label>
                <select runat="server" id="eventVenue" class="form-control"></select>
                <label for="eventDate">Event date:</label>
                <asp:TextBox ID="eventDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />
                <asp:Button ID="btnAddEvent" runat="server" CssClass="btn btn-success" Text="Create event" OnClick="btnAddEvent_Click" />
            </p>
        </div>
    </div>
</asp:Content>
