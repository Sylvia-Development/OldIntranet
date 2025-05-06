<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="target_management.aspx.cs" Inherits="target_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>
 
<h1>Target Management</h1>
<br />
<font style="font-size:small;" >Current financial year - R <asp:Label runat="server" ID="target"  OnLoad="getTotalTarget" > </asp:Label></font>
<br />
<asp:LinqDataSource ID="TargetsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="monthly_targets"
        OnSelecting="TargetsDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>

     <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="TargetsDataSource"
             OnItemUpdated ="RefreshPage">
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                
               
                
                
                
                <td>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("month") %>' />
                </td>
               
                <td>
                    R<asp:Label ID="Label3" runat="server" 
                        Text='<%# Eval("target_amount","{0:N2}") %>' />
                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                
                
            </tr>
        </ItemTemplate>
        
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
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                                
                                
                                
                                <th id="Th3" runat="server">
                                    Month</th>
                                
                                   <th id="Th1" runat="server">
                                    Target Amount
                                </th>   
                                 <th id="Th5" runat="server">
                                   </th> 
                                
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
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                
                
                
                
                <td>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("month") %>' />
                </td>
                
                <td>
                    <asp:TextBox  ID="amount" runat="server" 
                        Text='<%# Bind("target_amount") %>' />        
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>




</asp:Content>

