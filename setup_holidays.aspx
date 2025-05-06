<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_holidays.aspx.cs" Inherits="setup_holidays" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });

  
    
       
    
 </script>

 <h1>Holidays</h1>
<asp:LinqDataSource ID="HolidaysDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="holidays"
         EnableDelete="True" 
          OrderBy="dept_id,date"
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="HolidaysDataSource" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
              
                
                
                
                <td>
                     <asp:DropDownList Enabled="false" ID="dept_DropDownList"  
                                                      SelectedValue='<%# Bind("dept_id") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Quotes"></asp:ListItem>
                      <asp:ListItem Value="2" Text="Projects"></asp:ListItem>
                      
                            
                        </asp:DropDownList>
                    
                    
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("date") %>' />
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
                     <asp:DropDownList ID="dept_DropDownList"  
                                                      SelectedValue='<%# Bind("dept_id") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Quotes"></asp:ListItem>
                      <asp:ListItem Value="2" Text="Projects"></asp:ListItem>
                      
                            
                        </asp:DropDownList>
                </td>
                <td>
                   <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("date") %>' />  
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
                                
                               
                                
                                
                                <th id="Th3" runat="server">
                                    Department</th>
                                <th id="Th4" runat="server">
                                    Holiday Date</th>
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
                     <asp:DropDownList ID="dept_DropDownList"  
                                                      SelectedValue='<%# Bind("dept_id") %>' runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Quotes"></asp:ListItem>
                      <asp:ListItem Value="2" Text="Projects"></asp:ListItem>
                      
                            
                        </asp:DropDownList>
                </td>
                <td>
                   <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("date") %>' />  
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

