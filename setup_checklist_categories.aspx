<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_checklist_categories.aspx.cs" Inherits="setup_checklist_categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="ChecklistCategoriesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="wall_checklist_categories"
        OnSelecting="Checklist_Categories_DataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
     



<h1><%  String deptId = Page.Request.QueryString["pDepartmentId"];
        if (deptId !=null && deptId.Equals("0")) 
        { 
                Response.Write("Quote"); 
        }else if (deptId !=null && deptId.Equals("1")) 
        { 
                Response.Write("Production"); 
        }else if (deptId !=null && deptId.Equals("2")) 
        { 
                Response.Write("Projects"); 
        }
        else if (deptId != null && deptId.Equals("3"))
        {
            Response.Write("Plan Gen");
        }
        else if (deptId != null && deptId.Equals("4"))
        {
            Response.Write("Service");
        }
        
        
        
        
        %> Checklist Categories</h1>
        <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="ChecklistCategoriesDataSource" InsertItemPosition="LastItem"
            OnItemInserting="checklist_category_ItemInserting">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="description" runat="server" Text='<%# Eval("description") %>' />
                </td>
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server" 
                        Text='<%# Eval("category_order") %>' />
                </td>
                <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
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
                    <asp:TextBox ID="reminderTextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                        
                    
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" 
                        Text='<%# Bind("category_order") %>' />
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
                                    Checklist Category</th>
                                <th id="Th2" runat="server">
                                    Category Order</th>
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
                    <asp:TextBox ID="reminderTextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                        
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" 
                        Text='<%# Bind("category_order") %>' />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>








</asp:Content>

