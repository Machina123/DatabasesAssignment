<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemovePerformer.aspx.cs" Inherits="DatabasesAssignment.Admin.RemovePerformer" MasterPageFile="~/Site.Master" Title="Remove performer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Remove performer</h2>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="performerSelect" class="col-sm-2 control-label">Performer:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="performerSelect" runat="server" CssClass="form-control" EnableViewState="true"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10 col-sm-offset-2"><asp:Button ID="btnRemovePerf" runat="server" CssClass="btn btn-danger" Text="Remove performer" /></div>
        </div>
    </div>
</asp:Content>
