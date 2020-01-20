<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DatabasesAssignment._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="text-center">Welcome to TicketManager!</h2>

    <div class="row">
        <div runat="server" id="loginMessage">To continue, please <a href="/Register">create a new account</a> or <a href="/Login">log in</a>.</div>
        <div runat="server" id="userGreet">
            <h3 class="text-center">Hello, <% if (Session["username"] != null) Response.Write(Session["username"]); %>!</h3>
            <br />
            <div class="row">
                <div class="col-sm-4"><a href="/User/CreateOrder" class="btn btn-primary form-control">Create a new order...</a></div>
                <div class="col-sm-4"><a href="/User/MyOrders" class="btn btn-primary form-control">Show my orders...</a></div>
                <div runat="server" class="col-sm-4" id="adminOptions"><a href="/Admin/AdminPanel" class="btn btn-primary form-control">Administrator access...</a></div>
            </div>
        </div>
    </div>

</asp:Content>
