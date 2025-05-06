<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_sms_messages.aspx.cs" Inherits="setup_sms_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });

  
    
       
    
 </script>
<h1>Management Messages</h1>
<asp:LinqDataSource ID="ManagementMessagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="management_messages"
         EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ManagementMessagesListView" runat="server" DataKeyNames="id" 
            DataSourceID="ManagementMessagesDataSource" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
               
                
                
                
                <td>
                    <asp:TextBox Columns="50" Rows="5" ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" TextMode="MultiLine" ID="messageLabel" runat="server" 
                        Text='<%# Eval("message") %>' />
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("day") %>' />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" 
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
                    <asp:TextBox Columns="50" Rows="5" TextMode="MultiLine" ID="TextBox3" runat="server" 
                        Text='<%# Bind("message") %>' />
                </td>
                <td>
                   <asp:DropDownList ID="Day_DropDownList"  
                                                      SelectedValue='<%# Bind("day") %>'
                                                      
           
                                                     AppendDataBoundItems="True" runat="server">
                    <asp:ListItem Value="" Text="Select Specific Day"></asp:ListItem>
                      <asp:ListItem Value="Monday" Text="Monday"></asp:ListItem>
                      <asp:ListItem Value="Tuesday" Text="Tuesday"></asp:ListItem>
                      <asp:ListItem Value="Wednesday" Text="Wednesday"></asp:ListItem>
                      <asp:ListItem Value="Thursday" Text="Thursday"></asp:ListItem>
                      <asp:ListItem Value="Friday" Text="Friday"></asp:ListItem>
                            
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
                                    Message</th>
                                <th id="Th4" runat="server">
                                    Day</th>
                                   <th id="Th1" runat="server">
                                    Date
                                </th> 
                                
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
                    <asp:TextBox Columns="50" Rows="5" TextMode="MultiLine" ID="TextBox3" runat="server" 
                        Text='<%# Bind("message") %>' />
                </td>
                <td>
                   <asp:DropDownList ID="Day_DropDownList"  
                                                      SelectedValue='<%# Bind("day") %>'
                                                        
           
                                                      runat="server">
                      <asp:ListItem Value="" Text="Select Specific Day"></asp:ListItem>
                      <asp:ListItem Value="Monday" Text="Monday"></asp:ListItem>
                      <asp:ListItem Value="Tuesday" Text="Tuesday"></asp:ListItem>
                      <asp:ListItem Value="Wednesday" Text="Wednesday"></asp:ListItem>
                      <asp:ListItem Value="Thursday" Text="Thursday"></asp:ListItem>
                      <asp:ListItem Value="Friday" Text="Friday"></asp:ListItem>
                        
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

