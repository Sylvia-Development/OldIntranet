<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="management_client_info.aspx.cs" Inherits="management_client_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<clientInfo:clientInfoControl id="clientInfoSection" runat="server"
      insertReturnPath="management_client_info.aspx"
      updateReturnPath="management_dashboard.aspx">
    </clientInfo:clientInfoControl>
</asp:Content>

