<%@ Page Title="Add Venue" Language="C#" AutoEventWireup="true" CodeBehind="AddVenue.aspx.cs" Inherits="DatabasesAssignment.Admin.AddVenue" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Add new venue</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="venueName" class="control-label col-sm-2">Venue name:</label>
            <div class="col-sm-10">
                <asp:TextBox ID="venueName" TextMode="SingleLine" MaxLength="50" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="venueName" runat="server" ErrorMessage="This field is required" />
            </div>

        </div>
        <div class="form-group">
            <label for="venueAddr" class="control-label col-sm-2">Venue address:</label>
            <div class="col-sm-10">
                <asp:TextBox ID="venueAddr" TextMode="SingleLine" MaxLength="100" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator CssClass="text-danger" ControlToValidate="venueAddr" runat="server" ErrorMessage="This field is required" />
            </div>

        </div>
        <div class="form-group">
            <label for="venueCap" class="control-label col-sm-2">Venue capacity:</label>
            <div class="col-sm-10">
                <asp:TextBox ID="venueCap" TextMode="Number" runat="server" CssClass="form-control" />
                <asp:CompareValidator ControlToValidate="venueCap" ValueToCompare="0" Operator="GreaterThan" Type="Integer" CssClass="text-danger" runat="server" ErrorMessage="Value must be greater than 0" />
            </div>

        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2">
                <asp:Button ID="btnAddVenue" runat="server" CssClass="btn btn-success" Text="Add venue" />
            </div>
        </div>

    </div>
</asp:Content>
