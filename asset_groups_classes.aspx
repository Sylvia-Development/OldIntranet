<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="asset_groups_classes.aspx.cs" Inherits="asset_groups_classes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<h1>Select group or class to view</h1>
<br />
<table>
<tr>
<td>
<asp:ListView ID="groupsListView" runat="server" DataKeyNames="id" 
        DataSourceID="groupsDataSource">
        <ItemTemplate>
                
             <tr>

                <td nowrap> 
              
               <a href="asset_items.aspx?pType=group&pId=<%# Eval("id")%>"> <%# Eval("description")%> </a>
                
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Asset Groups.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"  colspan="2"   runat="server"> Asset Groups</th>
                                
                                
                                
                               
                                
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

      <asp:LinqDataSource ID="groupsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="asset_groups"
         OrderBy="description">
</asp:LinqDataSource>


</td>
<td  style="vertical-align:top;">



<asp:ListView ID="classListView" runat="server" DataKeyNames="id" 
        DataSourceID="classDataSource">
        <ItemTemplate>
                
             <tr>

                <td nowrap> 
              
               <a href="asset_items.aspx?pType=class&pId=<%# Eval("id")%>"> <%# Eval("description")%> </a>
                
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Asset Classes.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"  colspan="2"   runat="server"> Asset Classes</th>
                                
                                
                                
                               
                                
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

      <asp:LinqDataSource ID="classDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="asset_classes"
         OrderBy="description">
</asp:LinqDataSource>

</td>
</tr>
</table>



</asp:Content>

