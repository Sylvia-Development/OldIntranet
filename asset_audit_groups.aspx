<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="asset_audit_groups.aspx.cs" Inherits="asset_audit_groups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<h1>Which group would you like to audit?</h1>
<br />
<asp:ListView ID="groupsListView" runat="server" DataKeyNames="id" 
        DataSourceID="groupsDataSource">
        <ItemTemplate>
                
             <tr>

                <td nowrap> 

              <asp:LinkButton id="LinkButton" CommandArgument='<%# Eval("id")%>' Text=<%# Eval("description")%> OnClick="LinkButton_Click" runat="server"/>
               
                
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



</asp:Content>

