<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="uploaded_academy_items.aspx.cs" Inherits="uploaded_academy_items" %>
<%--<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
         
    <div style="margin:50px;">
        <asp:Button ID="backbtn" runat="server"  
                        Text="Back to Setup" OnClick="btnBackToSetup" style="padding:20px;" />
    </div>
    
    <br />
    <%--<div id="SignoffPlans">  
     <%if (true)//Context.User.IsInRole("Director"))
         { %> 
    <div runat="server" id="Div5">
           <CuteWebUI:Uploader runat="server" ID="Uploader6" InsertText="Item Path" OnFileUploaded="plans_FileUploaded">
                <ValidateOption AllowedFileExtensions="*" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>--%>
      <asp:LinqDataSource ID="AcademyItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="academy_items"
        OnSelecting="Academy_Items_DataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
       >
    </asp:LinqDataSource>
   


<h1><strong>  Academy Items</strong></h1>
        <br />
    <asp:ListView ID="AcademyItemsListView" runat="server" DataKeyNames="item_id" 
            DataSourceID="AcademyItemsDataSource" 
            OnItemCreate="academy_items_OnItemCreate" 
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
                     <asp:Label ID="Label3" runat="server" Text='<%# (Eval("item_type")).ToString()=="0"?"":getLabel((Int32)(Eval("item_type"))) %>' />
<%--                     <asp:Label ID="Label4" runat="server" Text='<%# (((Int32)Eval("item_type") == 0)?" ":getLabel((Int32) Eval("item_type"))) %>' />--%>

                </td>
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server"  Text='<%# Eval("item_order") %>' />
                </td>
                <td>
                    <asp:Label ID="reminder_orderTextBox" runat="server" Text='<%# Eval("academy_sub_menu.child_name") %>' />
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
           <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>

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
                    <asp:DropDownList  ID="DropDown3" Enabled="true"  SelectedValue='<%# Bind("item_type") %>' runat="server">
                            <asp:ListItem Value="0" Text="--Item Type--" Selected></asp:ListItem>
                            <asp:ListItem Value="1" Text="Video"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Pdf"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Image"></asp:ListItem>
                        </asp:DropDownList>
                   
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
<%--                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("user_added") %>' />--%>
                </td>
                <td>
<%--                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("date_added") %>' />--%>
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
                        <table ID="itemPlaceholderContainer" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                            <tr runat="server">
                               
                                
                               
                                <th runat="server">Item Name</th>
                                <th runat="server">Item Title</th>
                                <th runat="server">Item Description</th>
                                <th runat="server">Item Type</th>
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
                    <%--<asp:DropDownList  ID="Dropdown5" Enable="true" SelectedValue='<%# Bind("item_type") %>' runat="server">
                        <asp:ListItem Value="0" Text="--Item Type--" Selected></asp:ListItem>
                            <asp:ListItem Value="1" Text="Video"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Pdf"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Image"></asp:ListItem>
                        </asp:DropDownList>--%>
                   
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("academy_sub_menu.child_name")%>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("item_order") %>' />
                </td>
                
                <td>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("academy_sub_menu.child_name") %>' />
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
                    <asp:Label ID="TextBox5" runat="server" Text='<%# Bind("user_added") %>' />
                </td>
                <td>
                    <asp:Label ID="TextBox12" runat="server" Text='<%# Bind("added_date") %>' />
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

<asp:LinqDataSource ID="SubMenuLinqDataSource" runat="server" 
    ContextTypeName="IntranetDataDataContext" 
         TableName="academy_sub_menu" OnSelecting="academy_items_selecting"> 
</asp:LinqDataSource>

             </div>
</asp:Content>

