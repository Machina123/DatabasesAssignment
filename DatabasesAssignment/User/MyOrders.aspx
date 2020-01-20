<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="DatabasesAssignment.User.MyOrders" MasterPageFile="~/Site.Master" Title="My orders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h3 class="text-center">Your orders</h3>
    <hr />
    <div id="result" runat="server"></div>
</asp:Content>
