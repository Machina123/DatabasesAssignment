<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="DatabasesAssignment.User.CreateOrder" MasterPageFile="~/Site.Master" Title="Create order"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2 class="text-center">Create order</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="eventSelect" class="col-sm-2 control-label">Event:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="eventSelect" runat="server" CssClass="form-control" EnableViewState="true"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Number of tickets:</label>
            <div class="col-sm-10">
                <asp:TextBox ID="ticketCount" TextMode="Number" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ErrorMessage="This field is required" ControlToValidate="ticketCount" runat="server" CssClass="text-danger"/>
                <asp:CompareValidator ErrorMessage="Value must be greater than 0" ControlToValidate="ticketCount" runat="server" ValueToCompare="0" Operator="GreaterThan" Type="Integer" CssClass="text-danger" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2"><asp:Button ID="btnCreateOrder" runat="server" CssClass="btn btn-success" Text="Create order" /></div>
        </div>
    </div>
</asp:Content>