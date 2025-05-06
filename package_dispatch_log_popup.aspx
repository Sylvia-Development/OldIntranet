<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="package_dispatch_log_popup.aspx.cs" Inherits="package_dispatch_log_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="background:white; margin:5px;">
<div>
<br />
<h3 style="color:black;"> 
    <asp:Label ID="titleLabel" runat="server" Text="">Package Dispatch Log</asp:Label>   
</h3>
</div>
    <br />
 <asp:ListView ID="packageLogListView" runat="server" DataKeyNames="id" 
        
        DataSourceID="packageLogDataSource" 
           OnDataBound="page_load_finish">
        <ItemTemplate>
                
            <tr >
                <td > <%#Eval("datetime_stamp", "{0:ddd, d MMM, yyyy - H:mm}")%></td>
                <td > <%# Eval("event_description") %></td>            
                <td > <%#Eval("username") %></td>              
            </tr>
            
        </ItemTemplate>
      
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
           
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="0" class="themeContent" width="100%" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
        
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="packageLogDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="section_dispatch_log_items"
        OnSelecting="packageLogDataSource_Selecting">
</asp:LinqDataSource>




</div>





</asp:Content>

