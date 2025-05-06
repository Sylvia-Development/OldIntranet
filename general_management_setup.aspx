<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="general_management_setup.aspx.cs" Inherits="general_management_setup" %>

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
            <tr style="background-color:#DCDCDC;color: #000000;">
                
               <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                
                
                
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
                
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style=" background-color:Gray;">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                
                
                
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
                
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                                
                                <th id="Th5" runat="server">
                                   </th>  
                                
                                
                                <th id="Th3" runat="server">
                                    Message</th>
                                <th id="Th4" runat="server">
                                    Day</th>
                                   <th id="Th1" runat="server">
                                    Date
                                </th>   
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" 
                        style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                
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
                        <asp:ListItem Value="Saturday" Text="Sat"></asp:ListItem> 
                        <asp:ListItem Value="Sunday" Text="Sun"></asp:ListItem>    
                        </asp:DropDownList>
                </td>
                <td>
                   <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("date") %>' />       
                </td>
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>


<h1>Staff Birthdays</h1>
<asp:LinqDataSource ID="BirthdayDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="staff_birthdays"
         EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="birthdaysListView" runat="server" DataKeyNames="id" 
            DataSourceID="BirthdayDataSource" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                
               <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                
                
                
                <td>
                    <asp:TextBox ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" ID="messageLabel" runat="server" 
                        Text='<%# Eval("name") %>' />
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("date") %>' />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# Eval("birth_year") %>' />
                </td>
                
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style=" background-color:Gray;">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("name") %>' />
                </td>
                <td>
                   <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("date") %>' />  
                </td>
                <td>
                   <asp:TextBox   ID="birth" runat="server" 
                        Text='<%# Bind("birth_year") %>' />       
                </td>
                
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                                
                                <th id="Th5" runat="server">
                                   </th>  
                                
                                
                                <th id="Th3" runat="server">
                                    Name</th>
                                <th id="Th4" runat="server">
                                    Birthdate</th>
                                   <th id="Th1" runat="server">
                                    Birth Year
                                </th>   
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" 
                        style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("name") %>' />
                </td>
                <td>
                   <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("date") %>' />  
                </td>
                <td>
                   <asp:TextBox   ID="birth" runat="server" 
                        Text='<%# Bind("birth_year") %>' />       
                </td>
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>

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
            <tr style="background-color:#DCDCDC;color: #000000;">
                
               <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                
                
                
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
                
                
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style=" background-color:Gray;">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                
                
                
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
                
                
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                                
                                <th id="Th5" runat="server">
                                   </th>  
                                
                                
                                <th id="Th3" runat="server">
                                    Department</th>
                                <th id="Th4" runat="server">
                                    Holiday Date</th>
                                      
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" 
                        style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                
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
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>

    <br />

    <h1>Subscribed numbers to company sms's</h1>
<asp:LinqDataSource ID="NumbersLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="staff_cell_numbers"
         EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
 <asp:ListView ID="ListView2" runat="server" DataKeyNames="id" 
            DataSourceID="NumbersLinqDataSource" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                
               <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                
                
                
                <td>
                    <asp:TextBox ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" ID="messageLabel" runat="server" 
                        Text='<%# Eval("name") %>' />
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("number") %>' />
                </td>
                                
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style=" background-color:Gray;">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("name") %>' />
                </td>
                <td>
                   <asp:TextBox   ID="numbers" runat="server" 
                        Text='<%# Bind("number") %>' />  
                </td>
            
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                                
                                <th id="Th5" runat="server">
                                   </th>  
                                
                                
                                <th id="Th3" runat="server">
                                    Name</th>
                                <th id="Th4" runat="server">
                                    Cell Number</th>
                                      
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" 
                        style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" 
                        Text='<%# Bind("name") %>' />
                </td>
                <td>
                   <asp:TextBox   ID="number" runat="server" 
                        Text='<%# Bind("number") %>' />  
                </td>
                
                
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>





</asp:Content>

