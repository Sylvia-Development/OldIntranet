<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_default_checklist_items.aspx.cs" Inherits="setup_default_checklist_items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="CategoryLinqDataSource" runat="server"  
        ContextTypeName="IntranetDataDataContext" OrderBy="category_order" 
        Select="new (id, description)" 
        TableName="wall_checklist_categories">
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
        
        
        
        
        %> Checklist Defaults</h1>
        <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="ChecklistDataSource" InsertItemPosition="LastItem"
            OnItemInserting="checklist_ItemInserting">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="reminderLabel" runat="server" Text='<%# Eval("description") %>' />
                </td>
                <td>

                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("wall_checklist_category.description") %>' />

                </td>
                
                
                <td nowrap>
                    
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
                        Text='<%# Bind("description") %>'  Width="90%"/>
                        
                    
                </td>
                <td>
                     <asp:DropDownList Enabled="true" ID="Category_DropDownList" Width="100%" 
                                                     DataSourceID = "CategoryLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      
                                                      runat="server">
                         
                            
                        </asp:DropDownList>

                    <asp:DropDownList Visible="false" ID="type_DropDownList"  
                                                      SelectedValue='<%# Bind("item_type") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Initial" Selected="True"></asp:ListItem>
                      <asp:ListItem Value="1" Text="Finishing"></asp:ListItem>
                      
                            
                        </asp:DropDownList>

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
                                    Checklist Item</th>
                                <th id="Th3" runat="server">
                                    Category</th>
                               
                               
                                <th>&nbsp</th>
                                
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
                        Text='<%# Bind("description") %>' Width="90%" />
                        
                </td>
                <td><asp:DropDownList Enabled="true" ID="Category_DropDownList" Width="100%" 
                                                     DataSourceID = "CategoryLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      
                                                      SelectedValue='<%# Bind("category_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>

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
    

    <asp:LinqDataSource ID="ChecklistDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="wall_checklist_defaults"
        OnSelecting="ChecklistDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
     

</asp:Content>

