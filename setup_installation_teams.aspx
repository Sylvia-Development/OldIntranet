<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_installation_teams.aspx.cs" Inherits="setup_installation_teams" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<h1>Active Installation Teams</h1>
<asp:LinqDataSource ID="ActiveInstallersLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="installation_teams"
         EnableDelete="True" 
    OnSelecting="ActiveInstallers_Selecting"
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ActiveInstallersListView" runat="server" DataKeyNames="id" 
            DataSourceID="ActiveInstallersLinqDataSource" InsertItemPosition="FirstItem" OnItemInserting="activeInstallers_ItemInserting" 
     OnItemUpdated="activeInstallers_ItemUpdated">
        <ItemTemplate>
            <tr >
                
              
                
                <td>
                    <asp:TextBox ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" ID="messageLabel" runat="server" 
                        Text='<%# Eval("description") %>' />
                    
                </td>
                
                 <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    
                </td>
                                
                
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
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("description") %>' /> <asp:HiddenField runat="server" ID="statusId" Value="1"   />
                </td>
                
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    
                </td>
            
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                               
                                
                                
                                <th id="Th3" runat="server">
                                    Team Name</th>
                                
                                     <th id="Th5" runat="server">
                                   </th>  
                                      
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
                
                
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("description") %>' />
               
                   <asp:DropDownList Enabled="true" ID="dept_DropDownList"  
                                                      SelectedValue='<%# Bind("active_status") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Archive"></asp:ListItem>
                      <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                      
                            
                        </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X"/>
                </td>
                
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>
    <br />
   <br />
    <h1>Archived Installation Teams</h1>
<asp:LinqDataSource ID="ArchiveInstallersLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="installation_teams"
         EnableDelete="True" 
    OnSelecting="ArchiveInstallers_Selecting"
        EnableInsert="False" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ArchiveInstallersListView" runat="server" DataKeyNames="id" 
            DataSourceID="ArchiveInstallersLinqDataSource" OnItemUpdated="archiveInstallers_ItemUpdated" >
        <ItemTemplate>
            <tr >
                
              
                
                <td>
                    <asp:TextBox ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" ID="messageLabel" runat="server" 
                        Text='<%# Eval("description") %>' />
                </td>
                
                 <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    
                </td>
                                
                
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
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                               
                                
                                
                                <th id="Th3" runat="server">
                                    Team Name</th>
                                
                                     <th id="Th5" runat="server">
                                   </th>  
                                      
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
                
                
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("description") %>' />
               
                   <asp:DropDownList Enabled="true" ID="dept_DropDownList"  
                                                      SelectedValue='<%# Bind("active_status") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Archive"></asp:ListItem>
                      <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                      
                            
                        </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X"/>
                </td>
                
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>





</asp:Content>

