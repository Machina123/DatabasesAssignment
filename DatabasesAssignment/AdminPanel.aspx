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
        <div class="col-sm-6">
            <a href="/Admin/AddPerformer" class="btn btn-primary">Add performer</a>
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
            <h2>Create event</h2>
            <p>
                <label for="eventPerf">Performer:</label>
                <asp:DropDownList runat="server" ID="eventPerf" CssClass="form-control" EnableViewState="true" OnSelectedIndexChanged="eventPerf_SelectedIndexChanged"></asp:DropDownList>
                <label for="eventVenue">Venue:</label>
                <asp:DropDownList runat="server" ID="eventVenue" CssClass="form-control" EnableViewState="true" OnSelectedIndexChanged="eventVenue_SelectedIndexChanged"></asp:DropDownList>
                <label for="eventDate">Event date:</label>
                <asp:TextBox ID="eventDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />
                <asp:Button ID="btnAddEvent" runat="server" CssClass="btn btn-success" Text="Create event" OnClick="btnAddEvent_Click" />
            </p>
        </div>
        <div class="col-sm-6">
            <h2>Remove performe</h2>
            <p>
                <label for="perfSelect">Performer:</label>
                <asp:DropDownList ID="perfSelect" runat="server" cssclass="form-control" EnableViewState="true" OnSelectedIndexChanged="perfSelect_SelectedIndexChanged"></asp:DropDownList>
                <asp:Button ID="btnRemovePerformer" runat="server" CssClass="btn btn-danger" Text="Remove performer" OnClick="btnRemovePerformer_Click" />
            </p>
            <h2>Remove venue</h2>
            <p>
                <label for="venueSelect">Venue:</label>
                <asp:DropDownList ID="venueSelect" runat="server" CssClass="form-control" EnableViewState="true" OnSelectedIndexChanged="venueSelect_SelectedIndexChanged"></asp:DropDownList>
                <asp:Button ID="btnRemoveVenue" runat="server" CssClass="btn btn-danger" Text="Remove venue" OnClick="btnRemoveVenue_Click" />
            </p>
            <h2>Remove event</h2>
            <p>
                <label for="eventSelect">Event:</label>
                <asp:DropDownList ID="eventSelect" runat="server" CssClass="form-control" EnableViewState="true" OnSelectedIndexChanged="eventSelect_SelectedIndexChanged"></asp:DropDownList>
                <asp:Button ID="btnRemoveEvent" runat="server" CssClass="btn btn-danger" Text="Remove event" OnClick="btnRemoveEvent_Click" />
            </p>
        </div>
    </div>
</asp:Content>
