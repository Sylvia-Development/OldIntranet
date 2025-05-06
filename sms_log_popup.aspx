<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="sms_log_popup.aspx.cs" Inherits="sms_log_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   


<br />

<div style="background:white; color:black; padding:10px;">
  <asp:LinqDataSource ID="SmsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        OrderBy="date desc" TableName="sms_logs"
        OnSelecting="SmsDataSource_Selecting">
    </asp:LinqDataSource>

<asp:ListView ID="SmsListView" runat="server" DataKeyNames="client_id" 
        DataSourceID="SmsDataSource">
        <ItemTemplate>
            <tr >
                
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
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                
                <tr>
                    <td>
                        No sms has been sent.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <table id="Table2" width="100%" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table width="100%" ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" >
                            
                           <tr id="Tr2" runat="server" class="tableheaderrow">
                               
                                
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
               
            </table>
        </LayoutTemplate>
      
        
    </asp:ListView>





</div>



</asp:Content>

