<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_status.aspx.cs" Inherits="setup_status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

    <h1>Quote Statuses </h1>
    
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
            ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
            EnableInsert="True" EnableUpdate="True" OrderBy="display_order" 
            TableName="status" Where="department_id == @department_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="0" Name="department_id" Type="Int32" />
        </WhereParameters>
        <InsertParameters>
            <asp:Parameter Name="department_id" DefaultValue="0" />
        </InsertParameters>
        </asp:LinqDataSource>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="status_id" 
            DataSourceID="LinqDataSource1" InsertItemPosition="LastItem">
            <ItemTemplate>
                <tr >
                    
                    
                    <td>
                        <asp:Label ID="status_nameLabel" runat="server" 
                            Text='<%# Eval("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:Label ID="display_orderLabel" runat="server" 
                            Text='<%# Eval("display_order") %>' />
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
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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
                                   
                                    
                                    <th runat="server">
                                        Status Name</th>
                                
                                    <th runat="server">
                                        Display Order</th>
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
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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
   





<h1>Ops Dept. Statuses </h1>
    
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
            ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
            EnableInsert="True" EnableUpdate="True" OrderBy="display_order" 
            TableName="status" Where="department_id == @department_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="1" Name="department_id" Type="Int32" />
        </WhereParameters>
        <InsertParameters>
            <asp:Parameter Name="department_id" DefaultValue="1" />
        </InsertParameters>
        </asp:LinqDataSource>
        <asp:ListView ID="ListView2" runat="server" DataKeyNames="status_id" 
            DataSourceID="LinqDataSource2" InsertItemPosition="LastItem">
            <ItemTemplate>
                <tr >
                    
                    
                    <td>
                        <asp:Label ID="status_nameLabel" runat="server" 
                            Text='<%# Eval("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:Label ID="display_orderLabel" runat="server" 
                            Text='<%# Eval("display_order") %>' />
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
                <tr style="">
                    
                    
                    <td>
                        
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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
                                    
                                    
                                    <th id="Th2" runat="server">
                                        Status Name</th>
                                
                                    <th id="Th3" runat="server">
                                        Display Order</th>
                                        <th id="Th1" runat="server">
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
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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
   






 <h1>Service Call Statuses </h1>
    
    <asp:LinqDataSource ID="LinqDataSource5" runat="server" 
            ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
            EnableInsert="True" EnableUpdate="True" OrderBy="display_order" 
            TableName="status" Where="department_id == @department_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="4" Name="department_id" Type="Int32" />
        </WhereParameters>
        <InsertParameters>
            <asp:Parameter Name="department_id" DefaultValue="4" />
        </InsertParameters>
        </asp:LinqDataSource>
        <asp:ListView ID="ListView5" runat="server" DataKeyNames="status_id" 
            DataSourceID="LinqDataSource5" InsertItemPosition="LastItem">
            <ItemTemplate>
                <tr>
                    
                    
                    <td>
                        <asp:Label ID="status_nameLabel" runat="server" 
                            Text='<%# Eval("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:Label ID="display_orderLabel" runat="server" 
                            Text='<%# Eval("display_order") %>' />
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
                        
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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
                                    
                                    
                                    <th id="Th2" runat="server">
                                        Status Name</th>
                                
                                    <th id="Th3" runat="server">
                                        Display Order</th>
                                        <th id="Th1" runat="server">
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
                        <asp:TextBox ID="status_nameTextBox" runat="server" 
                            Text='<%# Bind("status_name") %>' />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="display_orderTextBox" runat="server" 
                            Text='<%# Bind("display_order") %>' />
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


