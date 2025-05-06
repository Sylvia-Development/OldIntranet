<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="setDefaultReminders.aspx.cs" Inherits="setDefaultReminders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
    <script type="text/javascript">
		$(document).ready(function () {
			
			$('.ReloadAllTasksButton').click(function () {

				if (!confirm('Are you sure you want to reload all tasks?')) {
					return false;
				}
			});






		});
	</script>
       <div>
            <asp:Button  ID="Button1" runat="server" class="ReloadAllTasksButton" Text="Reload Default Tasks" OnClick="reloadClick"/>

       </div>
	 <asp:LinqDataSource ID="UserRemDataSource" ContextTypeName="IntranetDataDataContext" runat="server"
                                    TableName ="reminder_default" OnSelecting="userReminders_OnSelecting"
                                    EnableInsert="True" EnableDelete="True" EnableUpdate="True"> 
     </asp:LinqDataSource>
                
   <h1>
       
       <%  String deptId = Page.Request.QueryString["pDepartmentId"];
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
        %> </h1>
    <asp:ListView ID="remindersListView" runat="server" DataKeyNames="id"
                DataSourseID="UserRemDataSource" OnItemInserting ="UseReminder_OnInserting" InsertItemPosition="LastItem">
            

                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Image ID="priority_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-hihg.png" />
                            &nbsp <asp:Label ID="lblReminder" runat="server" Text='<%# Eval("reminder") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblReminderOrder" runat="server" Text='<%# Eval("reminder_order") %>' />
                        </td>
                        <td>
                            <asp:Button ID="btnEdit1" runat="server" CommandName="Edit" Text="Edit" />
                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" />
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
                <LayoutTemplate>
                    <table runat="server" id="tblReminders" cellspacing="0" cellpadding="1" border="1">
                        <tr id="itemPlaceholder" runat="server">
                            <th> Reminder</th>
                            <th> Reminder Order</th>
                        </tr>

                    </table>
                </LayoutTemplate>
                <InsertItemTemplate>
                    <tr class="insertrow">
                        <td>
                            <asp:TextBox ID="txtReminder" runat="server" Text='<%# Bind("reminder") %>' />
                            <asp:CheckBox ID="checkReminder" runat="server" checked='<%# Bind("high_priority") %>'/><img src="Images/priority-high.png"/>
                        </td>
                        <td>
                            <asp:TextBox ID="txtReminderOrder" runat="server" Text='<%# Bind("reminder_order") %>' />
                        </td>
                        <td>
                            <asp:Button ID="btnReminderInsert" runat="server" CommandName="Insert" Text="Insert" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <tr class="editrow">
                        <td><asp:TextBox ID="TxtReminder" runat="server" Text='<%# Bind("reminder") %>'/>
                            <asp:CheckBox ID="chkreminder" runat="server" Checked='<%# Bind("high_priority") %>' /><img src="images/priority-high.png"/>
                        </td>
                        <td> <asp:TextBox ID="TxtReminderOrder" runat="server" Text='<%# Bind("reminder_order") %>'/></td>
                        <td>
                            <asp:Button ID="BtnUpdate" runat="server" CommandName="Update" Text="Updata" />
                            <asp:Button ID="BtnCancel" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </EditItemTemplate>

            </asp:ListView>
           
</asp:Content>

