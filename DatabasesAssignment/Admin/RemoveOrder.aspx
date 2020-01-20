<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveOrder.aspx.cs" Inherits="DatabasesAssignment.Admin.RemoveOrder" MasterPageFile="~/Site.Master" Title="Cancel order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Cancel order</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="orderSelect" class="col-sm-2 control-label">Order:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="orderSelect" runat="server" CssClass="form-control" EnableViewState="true"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2"><asp:Button ID="btnRemoveEvent" runat="server" CssClass="btn btn-danger" Text="Cancel selected order" /></div>
        </div>
    </div>
</asp:Content>
