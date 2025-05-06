<%@ Page Title="" Language="C#" MasterPageFile="~/QuoteLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="client_info.aspx.cs" Inherits="client_info" %>

 

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <clientInfo:clientInfoControl id="clientInfoSection" runat="server"
      insertReturnPath="section_info.aspx?pSectionId=-1"
      updateReturnPath="management_dashboard.aspx" >
    </clientInfo:clientInfoControl>
 
 
</asp:Content>

