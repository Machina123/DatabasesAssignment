<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="DatabasesAssignment.Admin.AdminPanel" %>

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
        <h2 class="text-center">TicketManager Admin Panel</h2>
        <div class="col-sm-6 col-sm-offset-3">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3 class="panel-title">Add...</h3>
                </div>
                <div class="panel-body">
                    <a href="/Admin/AddPerformer" class="btn btn-success btn-block">New performer</a>
                    <a href="/Admin/AddVenue" class="btn btn-success btn-block">New venue</a>
                    <a href="/Admin/AddEvent" class="btn btn-success btn-block">New event</a>
                </div>
            </div>
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Show...</h3>
                </div>
                <div class="panel-body">
                    <a href="/Admin/ShowUserOrders" class="btn btn-info btn-block">User orders</a>
                    <a href="/Admin/ShowEventOrders" class="btn btn-info btn-block">Event orders</a>
                </div>
            </div>
            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h3 class="panel-title">Remove...</h3>
                </div>
                <div class="panel-body">
                    <a href="/Admin/RemovePerformer" class="btn btn-danger btn-block">Remove performer</a>
                    <a href="/Admin/RemoveVenue" class="btn btn-danger btn-block">Remove venue</a>
                    <a href="/Admin/RemoveEvent" class="btn btn-danger btn-block">Cancel event</a>
                    <a href="/Admin/RemoveOrder" class="btn btn-danger btn-block">Cancel order</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
