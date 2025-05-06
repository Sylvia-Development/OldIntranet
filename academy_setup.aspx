<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="academy_setup.aspx.cs" Inherits="academy_setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">

      <br />
   <br />
            <asp:LinqDataSource ID="AcademyMenuDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="academy_menus"
        OnSelecting="Academy_Menu_DataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
       >
    </asp:LinqDataSource>
     <br />
  
<h1>  MainMenu</h1>
        <br />
    <asp:ListView ID="AcademyMenuListView" runat="server" DataKeyNames="id" 
            DataSourceID="AcademyMenuDataSource" InsertItemPosition="LastItem"
            OnItemInserting="academy_menu_ItemInserting"
            OnItemCreate="academy_menu_OnItemCreate" 
            onItemDeleting="delete_Menu_OnItemDeleting"
             >
        <ItemTemplate>
            <tr >
                
                
                <td>
                     <asp:Label ID="reminderLabel" runat="server" Text='<%# Eval("parent_name") %>' />
                </td>
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server" style="text-align:center;"  Text='<%# Eval("parent_order") %>' />
                </td>
                <td>
                    <asp:Label ID="academyContent" runat="server"  Text='<%# Eval("parent_content") %>' />
                </td>
                <td>  
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server"  OnClientClick="return confirm('Deleting the Main Menu item entails deleting the SubMenus and their content. Are sure you want to delete the MainMenu item?');" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
           <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>

            <tr class="insertrow">
                                               
                <td>
<%--                   <asp:requiredfieldvalidator id="required2" runat="server" ControlToValidate="reminderTextBox" ErrorMessage="Reminder cannot be blank." Visible="True" Display="None"></asp:requiredfieldvalidator> Reminder (required)--%>

                    <asp:TextBox ID="reminderTextBox" runat="server" 
                        Text='<%# Bind("parent_name") %>' />
                        
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("parent_order") %>' />
                </td>

                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("parent_content") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
           
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                            <tr runat="server">
                               
                                
                                <th runat="server"> Menu</th>
                                <th runat="server"> Order Number</th>
                                <th runat="server">Description</th>
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

            <table1 id="table1">
            <tr class="editrow">
                
                <td>
                    <%--<asp:requiredfieldvalidator id="required1" runat="server" ControlToValidate="reminderTextBox" ErrorMessage="Reminder cannot be blank."></asp:requiredfieldvalidator> Reminder <span style="font-size:12px;">(Reminder)</span>--%>
                     <asp:TextBox ID="reminderTextBox" runat="server"   Text='<%# Bind("parent_name") %>' />
                       
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("parent_order") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("parent_content") %>' />
                </td>
                
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </table1>
        <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            
        </EditItemTemplate>
       
    </asp:ListView>

   <br />
   <br />
            <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="academy_menus"
        OnSelecting="Academy_Menu_DataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
       >
    </asp:LinqDataSource>
     <br />

            <br />
  <asp:LinqDataSource ID="AcademySubMenuDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="academy_sub_menus"
        OnSelecting="Academy_Sub_Menu_DataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
       >
    </asp:LinqDataSource>
     <br />
  
<h1>  Sub-Menu</h1>
        <br />
    <asp:ListView ID="AcademySubMenuListView" runat="server" DataKeyNames="child_id" 
            DataSourceID="AcademySubMenuDataSource" InsertItemPosition="LastItem"
            OnItemInserting="academy_submenu_ItemInserting"
            OnItemInserted="academy_submenu_ItemInserted"
            OnItemCreate="academy_submenu_OnItemCreate" 
             >
        <ItemTemplate>
            <tr >
                <td>
                     <asp:Label ID="reminderLabel" runat="server" Text='<%# Eval("child_name") %>' />
                </td>
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server"  Text='<%# Eval("child_menu_order") %>' />
                </td>
                <%--<td>
                     <asp:Label ID="academyContent" runat="server"  Text='<%# Eval("child_description") %>' />
<%--                       <a href="default2.aspx?pSubMenuid=<%# Eval("child_id") %>"> </a>--%
                </td>--%>
                <td>
                    <asp:Label ID="parentMenuLabel" runat="server"  Text='<%# Eval("academy_menu.parent_name") %>' />
                </td>
                <td>
                      <a href="uploaded_academy_items.aspx?pSubMenuid=<%# Eval("child_id")%> ">Add Item >></a>

               </td>
                <td>  
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
           <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>

            <tr class="insertrow">
                                               
                <td>
<%--                   <asp:requiredfieldvalidator id="required2" runat="server" ControlToValidate="reminderTextBox" ErrorMessage="Reminder cannot be blank." Visible="True" Display="None"></asp:requiredfieldvalidator> Reminder (required)--%>

                    <asp:TextBox ID="reminderTextBox" runat="server" 
                        Text='<%# Bind("child_name") %>' />
                        
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("child_menu_order") %>' />
                </td>
          <%--      <td>
<%--                     <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("child_discription") %>' />--%
                    <a href="default2.aspx?pSubMenuid=<%# Eval("child_id") %>"> </a>

                </td>--%>
                <td>
                    <asp:DropDownList ID="selectParentMenu" Width="100%" 
                                                      DataSourceID = "ParentMenuLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="parent_name"
                                                      SelectedValue='<%# Bind("id") %>'
                                                      AppendDataBoundItems="true"    
                                                      runat="server">
                        <asp:ListItem Text="--- Select Menu ---" Value=""></asp:ListItem>
                        </asp:DropDownList>
                </td>
                
                <td>
                                <a href="uploaded_academy_items.aspx?pSubMenuid=<%# Eval("child_id")%> "> Add Item >></a>


                </td>

                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
           
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr runat="server">
                               
                                
                                <th runat="server">Sub Menu</th>
                                <th runat="server"> Order Number</th>
<%--                                <th runat="server">Url</th>--%>
                                <th runat="server">Menu</th>
                                <th runat="server">Add Item</th>
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

            <table1 id="table1">
            <tr class="editrow">
                
                <td>
                    <%--<asp:requiredfieldvalidator id="required1" runat="server" ControlToValidate="reminderTextBox" ErrorMessage="Reminder cannot be blank."></asp:requiredfieldvalidator> Reminder <span style="font-size:12px;">(Reminder)</span>--%>
                     <asp:TextBox ID="reminderTextBox" runat="server"   Text='<%# Bind("child_name") %>' />
                       
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("child_menu_order") %>' />
                </td>
<%--                <td>
                   <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("child_description") %>' />
<%--                    <a href="default2.aspx?pSubMenuid=<%# Eval("child_id") %>"> </a>--%
                </td>--%>
                <td>
                    <asp:DropDownList ID="selectParentMenu" Width="100%" 
                                                      DataSourceID = "ParentMenuLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="parent_name"
                                                      SelectedValue='<%# Bind("id") %>'
                                                      AppendDataBoundItems="true"    
                                                      runat="server">
                        <asp:ListItem Text="--- Select Team ---" Value=""></asp:ListItem>
                        </asp:DropDownList>
                </td>
                <td>
                     <a href="uploaded_academy_items.aspx?pSubMenuid=<%# Eval("child_id")%> ">Go to Add Items Page>></a>

<%--                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("child_description") %>' />--%>
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </table1>
        <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            
        </EditItemTemplate>
       
    </asp:ListView>

<asp:LinqDataSource ID="ParentMenuLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="academy_menu" OnSelecting="academy_menu_selecting"> 
</asp:LinqDataSource>
<br /><br />

<br />
   <br />
 
<script>

    function beforeDelete() { return (confirm('Are you sure you want to delete the selected item?')); }
</script>



</asp:Content>

