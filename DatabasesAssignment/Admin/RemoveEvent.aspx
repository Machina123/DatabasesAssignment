<%@ Page Title="Remove event" Language="C#" AutoEventWireup="true" CodeBehind="RemoveEvent.aspx.cs" Inherits="DatabasesAssignment.Admin.RemoveEvent" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Cancel event</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="eventSelect" class="col-sm-2 control-label">Event:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="eventSelect" runat="server" CssClass="form-control" EnableViewState="true"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2"><asp:Button ID="btnRemoveEvent" runat="server" CssClass="btn btn-danger" Text="Cancel selected event" /></div>
        </div>
    </div>
</asp:Content>
