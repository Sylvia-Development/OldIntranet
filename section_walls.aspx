<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_walls.aspx.cs" Inherits="section_walls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    function ConfirmDelete()
    {
      var x = confirm("Are you sure you want to delete wall?");
      if (x)
          return true;
      else
        return false;
    }
</script>    

<h1> 
   Walls for <%Response.Write(GetClientNameSection(Page.Request.QueryString["pSectionId"]));%>
</h1>
<br />
 <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="WallsDataSource" InsertItemPosition="FirstItem"
            OnItemInserting="walls_ItemInserting"
            OnItemDeleting="ListView1_ItemDeleting">
        <ItemTemplate>
            <tr >
                <asp:HiddenField runat="server" id="hiddenId" Value='<%# Eval("id") %>'/>
                
                <td>
                    <asp:Label ID="wallLabel" runat="server" Text='<%# Eval("wall_label") %>' />
                </td>
                <td>
                    <asp:Label ID="wallorderLabel" runat="server" 
                        Text='<%# Eval("wall_order") %>' />
                </td>
                <td align="center">


                    <%#GetVerifiedInfo(Eval("id"),Page.Request.QueryString["pSectionId"])%>



                </td>
                <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete"   OnClientClick="return ConfirmDelete();"
                        Text="Delete" />
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
                    <asp:TextBox ID="walllabelTextBox" runat="server" 
                        Text='<%# Bind("wall_label") %>' />
                        
                    
                </td>
                <td>
                    <asp:TextBox ID="wallorderTextBox" runat="server" 
                        Text='<%# Bind("wall_order") %>' />
                </td>
                <td>&nbsp</td>
                <td >
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                               
                                
                                <th id="Th1" runat="server">
                                    Wall Description</th>
                                <th id="Th2" runat="server">
                                    Wall Order</th>
                                <th id="Th3" runat="server">
                                    Checklist Items Verified
                                </th>
                                <th id="Th4" runat="server">
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
                    <asp:TextBox ID="walllabelTextBox" runat="server" 
                        Text='<%# Bind("wall_label") %>' />
                        
                </td>
                <td>
                    <asp:TextBox ID="wallorderTextBox" runat="server" 
                        Text='<%# Bind("wall_order") %>' />
                </td>
                <td>&nbsp</td>
                <td >
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>




<asp:LinqDataSource ID="WallsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="walls"
        OnSelecting="WallsDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
         OnInserted="walls_ItemInserted">
    </asp:LinqDataSource>



</asp:Content>

