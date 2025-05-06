<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_asset_classes.aspx.cs" Inherits="setup_asset_classes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<h1>Asset Classes</h1>
<asp:LinqDataSource ID="LinqDataSource4" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" OrderBy="description" 
        TableName="asset_classes">
    </asp:LinqDataSource>
  <asp:ListView ID="ListView3" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource4" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="Label" runat="server" 
                        Text='<%# Eval("description") %>' />
                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
      
        <EmptyDataTemplate>
            <table id="Table1" runat="server">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="TextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
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
                                
                                
                                <th id="Th1" runat="server">
                                    Class Description</th>
                                    <th id="Th2" runat="server">
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
                    <asp:TextBox ID="TextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>

</asp:Content>

