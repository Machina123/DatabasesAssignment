<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveVenue.aspx.cs" Inherits="DatabasesAssignment.Admin.RemoveVenue" MasterPageFile="~/Site.Master" Title="Remove venue" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Remove venue</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="venueSelect" class="col-sm-2 control-label">Venue:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="venueSelect" runat="server" CssClass="form-control" EnableViewState="true"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2">
                <asp:Button ID="btnRemoveVenue" runat="server" CssClass="btn btn-danger" Text="Remove venue" />
            </div>
        </div>
    </div>
</asp:Content>
