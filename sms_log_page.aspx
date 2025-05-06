<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="sms_log_page.aspx.cs" Inherits="sms_log_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<h1> 
    <asp:Label ID="clientNameLabel" runat="server" OnLoad="getClientName" Text=""></asp:Label>  -  Sms Log
</h1>

     <asp:button id="btnBack" runat="server" text="<< Back" 
OnClientClick="JavaScript: window.history.back(1); return false;"></asp:button>


<br />
&nbsp
<hr />
  <asp:LinqDataSource ID="SmsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        OrderBy="date desc" TableName="sms_logs"
        OnSelecting="SmsDataSource_Selecting">
    </asp:LinqDataSource>

<asp:ListView ID="SmsListView" runat="server" DataKeyNames="client_id" 
        DataSourceID="SmsDataSource">
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                
                <td>
                    <asp:Label  ID="dateLabel" runat="server" Text='<%# Eval("date") %>' />
                </td>
                <td>
                   <asp:Label ID="messageLabel" runat="server" Text='<%# Eval("message") %>' />
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" Text='<%# Eval("sms_numbers") %>' />
                </td>
                <td>
                   <asp:Label ID="Label2" runat="server" Text='<%# Eval("sms_status") %>' />
                </td>
                <td>
                    <asp:Label ID="user_nameLabel" runat="server" Text='<%# Eval("user_name") %>' />
                </td>
               
            </tr>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <tr style="background-color:#FFF8DC;">
                
               <td>
                    <asp:Label ID="dateLabel"  runat="server" Text='<%# Eval("date") %>' />
                </td>
                <td>
                   <asp:Label ID="messageLabel" runat="server" Text='<%# Eval("message") %>' />
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" Text='<%# Eval("sms_numbers") %>' />
                </td>
                <td>
                   <asp:Label ID="Label2" runat="server" Text='<%# Eval("sms_status") %>' />
                </td>
                <td>
                    <asp:Label ID="user_nameLabel" runat="server" Text='<%# Eval("user_name") %>' />
                </td>
                
            </tr>
        </AlternatingItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <table id="Table2" width="100%" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table width="100%" ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                           <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                               
                                
                                <th id="Th2" runat="server">
                                    Date</th>
                                <th id="Th3" runat="server">
                                    Message</th>
                                    <th id="Th1" runat="server">
                                    Sms Numbers</th>
                                    <th id="Th4" runat="server">
                                    Sms Status</th>
                                     <th id="Th5" runat="server">
                                    Sent By</th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" 
                        style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
      
        
    </asp:ListView>








</asp:Content>

