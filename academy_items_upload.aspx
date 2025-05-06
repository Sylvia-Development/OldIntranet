<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="academy_items_upload.aspx.cs" Inherits="academy_items_upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
    <h1>  Academy Items for <%= Int32.Parse(Page.Request.QueryString["pSubMenuid"]) %></h1>
    <h1> Count: <%= (from r in (new IntranetDataDataContext()).academy_items
						where r.child_id == Int32.Parse(Page.Request.QueryString["pSubMenuid"])
						orderby r.item_order
						select r).Count() %></h1>
        <br />
    <div>
    <asp:ListView ID="AcademyItemsListView" runat="server" DataKeyNames="item_id" 
            DataSourceID="AcademyItemsDataSource"
            OnSelecting="Academy_Items_DataSource_Selecting"
            InsertItemPosition="LastItem"
            OnItemInserting="academy_Items_ItemInserting"
            OnItemInserted="academy_Items_ItemInserted"
            
            
             >
        <ItemTemplate>
            <tr >
                <td>
                     <asp:Label ID="reminderLabel" runat="server" Text='<%# Eval("item_name") %>' />
                </td>
                <td>
                     <asp:Label ID="Label1" runat="server" Text='<%# Eval("item_title") %>' />
                </td>
                <td>
                     <asp:Label ID="Label2" runat="server" Text='<%# Eval("item_description") %>' />
                </td>
                
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server"  Text='<%# Eval("item_order") %>' />
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Eval("academy_sub_menu.child_name") %>' />
                </td>
                <td>
                    <asp:Label ID="academyContent" runat="server"  Text='<%# Eval("user_added") %>' />
                </td>
                
                <td>
                    <asp:Label ID="parentMenuLabel" runat="server"  Text='<%# Eval("added_date") %>' />
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
           
            <tr class="insertrow">
                
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("item_name") %>' />
                    
                </td>
                <td>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("item_title") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("item_description") %>' />
                </td>
                
                <td>
                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("item_order") %>' />
                </td>
                
                <td>
                    
<%--                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("child_id") %>' />--%>
                

                    <%--<asp:DropDownList ID="selectSubMenu" Width="100%" 
                                                      DataSourceID = "SubMenuLinqDataSource" 
                                                      DataValueField = "child_id"  
                                                      DataTextField="child_name"
                                                      SelectedValue='<%# Bind("child_id") %>'
                                                      AppendDataBoundItems="true"    
                                                      runat="server">
                        <asp:ListItem Text="--- Select Sub-Menu ---" Value=""></asp:ListItem>
                        </asp:DropDownList>--%>
                </td>
                <td>
                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("user_added") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("date_added") %>' />
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
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                               
                                
                               
                                <th runat="server">Item Name</th>
                                <th runat="server">Item Title</th>
                                <th runat="server">Item Description</th>
                                <th runat="server">Item Order Number</th>
                                <th runat="server"> SubMenu</th>
                                <th runat="server">User</th>
                                <th runat="server">Added-Date</th>
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
                     <asp:TextBox ID="reminderTextBox" runat="server"   Text='<%# Bind("item_name") %>' />
                       
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("item_title") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("item_description") %>' />
                </td>

                
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("item_order") %>' />
                </td>
                
                <td>
<%--                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("academy_sub_menu.child_name") %>' />--%>
                    <%--<asp:DropDownList ID="selectParentMenu" Width="100%" 
                                                      DataSourceID = "SubMenuLinqDataSource" 
                                                      DataValueField = "child_id"  
                                                      DataTextField="child_name"
                                                      SelectedValue='<%# Bind("child_id") %>'
                                                      AppendDataBoundItems="true"    
                                                      runat="server">
                        <asp:ListItem Text="---  Sub-Menu ---" Value=""></asp:ListItem>
                        </asp:DropDownList>--%>
                </td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("user_added") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("added_date") %>' />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </table1>
            
        </EditItemTemplate>
       
    </asp:ListView>

<asp:LinqDataSource ID="AcademyItemsDataSource" runat="server" 
    ContextTypeName="IntranetDataDataContext"  EnableDelete="true"
    EnableInsert="true" EnableUpdate="true"
         TableName="academy_items"> 
</asp:LinqDataSource>
</div>
</asp:Content>

