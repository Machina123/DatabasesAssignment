<%@ Page Title="Add performer" Language="C#" AutoEventWireup="true" CodeBehind="AddPerformer.aspx.cs" Inherits="DatabasesAssignment.Admin.AddPerformer" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" runat="server" visible="false" id="errorContainer">
        <div class="col-sm-12">
            <div id="errorAlert" class="alert alert-danger" runat="server"></div>
        </div>
    </div>
    <h2>Add new performer</h2>
    <div>
        <div class="form-group">
            <label for="perfName">Performer name:</label>
            <asp:TextBox ID="perfName" TextMode="SingleLine" MaxLength="50" runat="server" CssClass="form-control" />
            <asp:RequiredFieldValidator ControlToValidate="perfName" runat="server" CssClass="text-danger" ErrorMessage="This field is required" />
        </div>
        <asp:Button ID="btnAddPerformer" runat="server" CssClass="btn btn-success" Text="Add performer" />
    </div>
</asp:Content>
