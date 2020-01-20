<%@ Page Title="Show user orders" Language="C#" AutoEventWireup="true" CodeBehind="ShowUserOrders.aspx.cs" Inherits="DatabasesAssignment.Admin.ShowUserOrders" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <div class="form-inline">
        <div class="form-group">
            <label>User:</label>
            <asp:DropDownList ID="userSelect" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Show orders" />
    </div>
    <hr />
    <div id="result" runat="server"></div>
</asp:Content>
