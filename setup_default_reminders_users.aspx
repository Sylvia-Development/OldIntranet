<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="setup_default_reminders_users.aspx.cs" Inherits="setup_default_reminders_users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="ContactDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="reminder_defaults_by_users"
        OnSelecting="ContactDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
       >
    </asp:LinqDataSource>
     <br />
  



<h1><%  String deptId = Page.Request.QueryString["pDepartmentId"];
		String userName = "";
		userName = Context.User.Identity.Name;
		Response.Write(userName);
        Response.Write("   <br/>  ");
		

		if (deptId !=null && deptId.Equals("0"))
		{
			Response.Write("Quote");

		}else if (deptId !=null && deptId.Equals("1"))
		{
			Response.Write("Operations");


		}else if (deptId !=null && deptId.Equals("2"))
		{
			Response.Write("Site Coordinator");
		}
		else if (deptId != null && deptId.Equals("8"))
		{
			Response.Write("Technical Services");
		}
		else if (deptId != null && deptId.Equals("4"))
		{
			Response.Write("Service");
		}
		else if (deptId != null && deptId.Equals("6"))
		{
			Response.Write("CEM");
		}
		else if (deptId != null && deptId.Equals("7"))
		{
			Response.Write("Projects Director");
		}
		else if (deptId != null && deptId.Equals("20"))
		{
			Response.Write("Technical Plan Generation");
		}




        %>  -My Default Reminders</h1>
        <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="ContactDataSource" InsertItemPosition="LastItem"
            OnItemInserting="contact_reminder_ItemInserting"
            OnItemCreate="events_to_add_OnItemCreate" 
             >
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Image ID="high_pri_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-high.png" />&nbsp <asp:Label ID="reminderLabel" runat="server" Text='<%# Eval("reminder") %>' />
                </td>
                <td>
                    <asp:Label ID="reminder_orderLabel" runat="server"  Text='<%# Eval("reminder_order") %>' />
                </td>
                <td>
                    <asp:Label ID="Label1" runat="server"  Text='<%#  (((Int32)Eval("event_to_add") == 0)?" ":getLabel((Int32) Eval("event_to_add"))) %>' />
                </td>
                <%--<td>
                    <asp:DropDownList ID="ddlEvent" Enabled="true" runat="server" AppendDataBoundItems="true"/>
                </td>--%>
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
<%--                   <asp:requiredfieldvalidator id="required2" runat="server" ControlToValidate="reminderTextBox" ErrorMessage="Reminder cannot be blank." Visible="True" Display="None"></asp:requiredfieldvalidator> Reminder (required)--%>

                    <asp:TextBox ID="reminderTextBox" runat="server" 
                        Text='<%# Bind("reminder") %>' />
                        
                     <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("high_priority") %>'  /><img src="Images/priority-high.png" />   
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("reminder_order") %>' />
                </td>
               <td>
                <asp:DropDownList  ID="ddlEvent2" runat="server" Enabled="true" CssClass="ui-corner-all ui-widget-content" SelectedValue='<%# Bind("event_to_add") %>'><asp:ListItem Value="0" Text="--Select an event--" Selected></asp:ListItem> 
                                                                                                                            <asp:ListItem Value="1" Text="Add Section"></asp:ListItem>
                                                                                                                            <asp:ListItem Value="4" Text="In Ops Dept"></asp:ListItem>
                                                                                                                          <asp:ListItem Value="2" Text="Set to Won"></asp:ListItem>
                                                                                                                          <asp:ListItem Value="3" Text="Job Close"></asp:ListItem>
                                                                                                                          
                     </asp:DropDownList>
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
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable" >
                            <tr runat="server" class="tableheaderrow">
                               
                                
                                <th runat="server"> Reminder</th>
                                <th runat="server">Reminder Order</th>
                                <th runat="server">Event</th>
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
                     <asp:TextBox ID="reminderTextBox" runat="server"   Text='<%# Bind("reminder") %>' />
                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("high_priority") %>'  /><img src="Images/priority-high.png" />   
                </td>
                <td>
                    <asp:TextBox ID="reminder_orderTextBox" runat="server" Text='<%# Bind("reminder_order") %>' />
                </td>
                <%--<td>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("event_to_add") %>' />
                </td>--%>
                <td>
                     <asp:DropDownList  ID="ddlEvent1" runat="server" Enabled="True" SelectedValue='<%# Bind("event_to_add") %>'> <asp:ListItem Value="0" Text="--Select an event--" Selected></asp:ListItem>
                                                                                                                                  <asp:ListItem Value="1" Text="Add Section"></asp:ListItem>
                                                                                                                                   <asp:ListItem Value="4" Text="In Ops Dept"></asp:ListItem>
                                                                                                                                  <asp:ListItem Value="2" Text="Set to Won"></asp:ListItem>
                                                                                                                                  <asp:ListItem Value="3" Text="Job Close"></asp:ListItem>
                                                                                                                                  
                     </asp:DropDownList>
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

</asp:Content>

