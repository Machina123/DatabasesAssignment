<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEvent.aspx.cs" Inherits="DatabasesAssignment.Admin.AddEvent" Title="Create event" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Create event</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="eventPerf" class="control-label col-sm-2">Performer:</label>
            <div class="col-sm-10">
                <asp:DropDownList runat="server" ID="eventPerf" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="eventPerf" runat="server" ErrorMessage="This field is required" />
            </div>
        </div>
        <div class="form-group">
            <label for="eventVenue" class="control-label col-sm-2">Venue:</label>
            <div class="col-sm-10">
                <asp:DropDownList runat="server" ID="eventVenue" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="eventVenue" runat="server" ErrorMessage="This field is required" />
            </div>
        </div>
        <div class="form-group">
            <label for="eventDate" class="control-label col-sm-2">Event date:</label>
            <div class="col-sm-10">
                <asp:TextBox ID="eventDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />
                <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="eventDate" runat="server" ErrorMessage="This field is required" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2">
                <asp:Button ID="btnAddEvent" runat="server" CssClass="btn btn-success" Text="Create event" />
            </div>
        </div>
    </div>
</asp:Content>
