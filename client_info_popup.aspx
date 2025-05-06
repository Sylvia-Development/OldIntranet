<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="client_info_popup.aspx.cs" Inherits="client_info_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     
    <div style="background:white;color:black;">
    <div id="container">

<div id="one_column" >
    <clientInfo:clientInfoControl id="clientInfoSection" runat="server"
      insertReturnPath="section_info_new.aspx?pSectionId=-1"
      updateReturnPath="client_info_popup.aspx" >
    </clientInfo:clientInfoControl>
 </div>
 </div>
    </div>
   

</asp:Content>

