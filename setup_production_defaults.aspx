<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_production_defaults.aspx.cs" Inherits="setup_production_defaults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<h1>Production Defaults</h1>
<asp:LinqDataSource ID="ProductionDefaultsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="production_lead_times"
         EnableDelete="False" 
          OrderBy="id"
        EnableInsert="False" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="ProductionDefaultsDataSource">
        <ItemTemplate>
            <tr >
                
              
                
                
                
                <td>
                     
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# Eval("client_lead_time") %>' />
                    
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("production_buffer") %>' />
                </td>
                 <td>
                     
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# Eval("plan_generation") %>' />
                    
                </td>
                <td>
                   <asp:Label ID="Label4" runat="server" 
                        Text='<%# Eval("supplier_orders") %>' />
                </td>
                 <td>
                     
                    <asp:Label ID="Label5" runat="server" 
                        Text='<%# Eval("finishes") %>' />
                    
                </td>
                <td>
                   <asp:Label ID="Label6" runat="server" 
                        Text='<%# Eval("cabinets") %>' />
                </td>
                 
                <td>
                   <asp:Label ID="Label8" runat="server" 
                        Text='<%# Eval("cabinets_before_finishes") %>' />
                </td>
                <td>
                     
                    <asp:Label ID="Label7" runat="server" 
                        Text='<%# Eval("custom_structures") %>' />
                    
                </td>
                 <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    
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
       
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                               
                                
                                
                                <th id="Th3" runat="server">
                                    Client Lead Time</th>
                                <th id="Th4" runat="server">
                                    Production Buffer</th>
                                <th id="Th1" runat="server">
                                    Plan Generation</th>
                                <th id="Th2" runat="server">
                                    Supplier Orders</th>
                                <th id="Th6" runat="server">
                                    Finishes</th>
                                <th id="Th7" runat="server">
                                    Cabinets</th>
                                <th id="Th9" runat="server">
                                    Cabinets before Finishes</th>
                                <th id="Th8" runat="server">
                                    Structures</th>


                                      <th id="Th5" runat="server">
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
                     
                    <asp:TextBox ID="Label2" runat="server" 
                        Text='<%# Bind("client_lead_time") %>' />
                    
                </td>
                <td>
                   <asp:TextBox ID="Label1" runat="server" 
                        Text='<%# Bind("production_buffer") %>' />
                </td>
                 <td>
                     
                    <asp:TextBox ID="Label3" runat="server" 
                        Text='<%# Bind("plan_generation") %>' />
                    
                </td>
                <td>
                   <asp:TextBox ID="Label4" runat="server" 
                        Text='<%# Bind("supplier_orders") %>' />
                </td>
                 <td>
                     
                    <asp:TextBox ID="Label5" runat="server" 
                        Text='<%# Bind("finishes") %>' />
                    
                </td>
                <td>
                   <asp:TextBox ID="Label6" runat="server" 
                        Text='<%# Bind("cabinets") %>' />
                </td>
                 
                <td>
                   <asp:TextBox ID="Label8" runat="server" 
                        Text='<%# Bind("cabinets_before_finishes") %>' />
                </td>
                <td>
                     
                    <asp:TextBox ID="Label7" runat="server" 
                        Text='<%# Bind("custom_structures") %>' />
                    
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

