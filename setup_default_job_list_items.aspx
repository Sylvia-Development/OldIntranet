<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_default_job_list_items.aspx.cs" Inherits="setup_default_job_list_items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="DefaultJobListDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="job_list_item_defaults"
        OnSelecting="JobListDefaultsDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>

    <asp:ListView ID="DefaultListView" runat="server" DataKeyNames="id" 
            DataSourceID="DefaultJobListDataSource" InsertItemPosition="LastItem"
            OnItemInserting="default_job_list_ItemInserting">
        <ItemTemplate>
            <tr >
                
                
                
                <td>
                    <%# Eval("description")%>
                </td>
                 
                
                <td >
                         <asp:DropDownList ID="DropDownList2" Enabled="false" Width="100%"  
                                               
                                                      SelectedValue='<%# Eval("type") %>'
                                                      
                                                      runat="server">
                            <asp:ListItem Value="0" Text="Initial Orders"></asp:ListItem>
                            <asp:ListItem Value="1" Text="AO Orders"></asp:ListItem>
                            <asp:ListItem Value="" Text="--"></asp:ListItem>
                        </asp:DropDownList>
                
                
                </td>
                <td>
                    <%# Eval("supplier_lead_time")%>
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Eval("is_main_material_order") %>' Enabled='false' />
                 
                </td>


                <td class="TDwithButtons">
                <%# Eval("list_item_order")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    
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
                    <asp:TextBox TextMode="MultiLine" Rows="7" Columns="60" ID="descriptionTextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                </td>
                <td>
                         <asp:DropDownList ID="DropDownList2" Enabled="true" Width="100%"  
                                               
                                                      SelectedValue='<%# Bind("type") %>'
                                                      
                                                      runat="server">
                             <asp:ListItem Value="" Text="------------"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Initial Orders"></asp:ListItem>
                            <asp:ListItem Value="1" Text="AO Orders"></asp:ListItem>
                            
                        </asp:DropDownList>
                
                
                </td>
                <td>
                <asp:TextBox Columns="1" ID="TextBox2" runat="server" 
                        Text='<%# Bind("supplier_lead_time") %>' />
                
                </td>
               
                    <td align="center">
                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("is_main_material_order") %>' Enabled='true' />
                 
                </td>
               
                <td class="TDwithButtons">
                    <asp:TextBox Columns="1" ID="TextBox1" runat="server" 
                        Text='<%# Bind("list_item_order") %>' />
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
                                List Item Description
                                </th>
                                
                                <th id="Th2" runat="server">
                                    Item Type&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</th>
                                <th id="Th3" runat="server">
                                    Supplier Lead Time</th>
                                 <th id="Th4" runat="server">
                                    Is Main Material</th>
                                    <th id="Th5" runat="server">
                               &nbsp
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
                    <asp:TextBox TextMode="MultiLine" Rows="7" Columns="60" ID="descriptionTextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                </td>
                <td>
                         <asp:DropDownList ID="DropDownList2" Enabled="true" Width="100%"  
                                               
                                                      SelectedValue='<%# Bind("type") %>'
                                                      
                                                      runat="server">
                             <asp:ListItem Value="" Text="----------"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Initial Orders"></asp:ListItem>
                            <asp:ListItem Value="1" Text="AO Orders"></asp:ListItem>
                            
                        </asp:DropDownList>
                
                
                </td>
                <td>
                <asp:TextBox Columns="2" ID="TextBox2" runat="server" 
                        Text='<%# Bind("supplier_lead_time") %>' />
                
                </td>
               
                    <td align="center">
                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("is_main_material_order") %>' Enabled='true' />
                 
                </td>
               
                <td class="TDwithButtons">
                    <asp:TextBox Columns="2" ID="TextBox1" runat="server" 
                        Text='<%# Bind("list_item_order") %>' />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
                
            </tr>
        </EditItemTemplate>
      
    </asp:ListView>





</asp:Content>

