<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DatabasesAssignment.Login" MasterPageFile="Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" EnableViewState="true" runat="server">
    <div class="alert alert-danger" runat="server" visible="false" id="executeResult">
    </div>
    <div class="row" style="margin-top: 16px;">
        <div class="col-sm-12">
            <div class="form-group">
                <label for="login">Login: </label>
                <asp:TextBox ID="login" runat="server" CssClass="form-control" TextMode="SingleLine" MaxLength="50" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="login" ErrorMessage="This field is required" CssClass="text-danger" />
            </div>
            <div class="form-group">
                <label for="email">E-mail address:</label>
                <asp:TextBox ID="email" runat="server" CssClass="form-control" TextMode="Email" MaxLength="100" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="email" ErrorMessage="This field is required" CssClass="text-danger" />
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <asp:TextBox ID="password" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="password" ErrorMessage="This field is required" CssClass="text-danger" />
            </div>
            <div class="form-group">
                <label for="password_confirm">Confirm password:</label>
                <asp:TextBox ID="password_confirm" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                <asp:CompareValidator runat="server"
                    ControlToCompare="password"
                    ControlToValidate="password_confirm"
                    Operator="Equal" Type="String"
                    ErrorMessage="Passwords do not match"
                    CssClass="text-danger" />
            </div>
            <button type="submit" class="btn btn-success">Register</button>
        </div>
    </div>
</asp:Content>
