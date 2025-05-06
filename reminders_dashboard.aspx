<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="reminders_dashboard.aspx.cs" Inherits="reminders_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">


<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });
    });


    
</script>
<div class="titleDiv">
 <h1><%  String deptId = Page.Request.QueryString["pDepartmentId"];
		 /*String userName = Page.Request.QueryString["pUserName"];*/
		 String userName = Context.User.Identity.Name;
		 Response.Write(userName);
		 Response.Write("   <br/>  ");
		 if (deptId != null && deptId.Equals("0"))
		 {
			 Response.Write("Consultant Quote Reminders");
			 /*if (userName != null && userName.Length > 0)
             {
                 Response.Write(" - " + userName);
             }
             else
             {
                 Response.Write(" - All Consultants");
             }   */

		 }
		 else if (deptId != null && deptId.Equals("1"))
		 {
			 Response.Write("Production Reminders");
		 }
		 else if (deptId != null && deptId.Equals("2"))
		 {
			 Response.Write("Projects Reminders");
		 }

		 else if (deptId != null && deptId.Equals("8"))
		 {
			 Response.Write("Technical Services & Service Call Reminders");
		 }
		 else if (deptId != null && deptId.Equals("7"))
		 {
			 Response.Write("Projects Director Reminders");
		 }
		 else if (deptId != null && deptId.Equals("20"))
		 {
			 Response.Write("Technical Plan Generation Reminders");
		 }
		 else if (deptId != null && deptId.Equals("15"))
		 {
			 Response.Write("Design Administrators Reminders <br/>");
		 }
		 else
		 {
			 Response.Write("My Reminders");
		 }
		 /*Response.Write("  <br/>");*/
%></h1>
<div id="toolbar">
<%
    
    String seeAll = Page.Request.QueryString["pSeeAll"];

    if (deptId != null && deptId.Equals("0"))
    {
        if (Context.User.IsInRole("Design Consultant"))
        {
            if (seeAll == null || seeAll.Length == 0)
            {
                Response.Write("<a href=\"reminders_dashboard.aspx?pDepartmentId=0&pSeeAll=yes\">  <img src=\"Images/allconsultants.png\" title=\"all consultants\" />   </a>");

            }

        }
        else
        {

            if (userName != null && userName.Length > 0)
            {
                Response.Write("<a href=\"reminders_dashboard.aspx?pDepartmentId=0&pSeeAll=yes\"> <img src=\"Images/allconsultants.png\" title=\"all consultants\" />   </a>");

            }



        }
    }%>
</div></div>
    <%
    if (deptId != null && deptId.Equals("0"))
    {
      %>
<br />
    <br />
 <asp:ListView ID="NoSectionListView" runat="server"
        DataSourceID="NoSectionLinqDataSource">
        <ItemTemplate>
        <tr >
        <td><a href="client_info_new.aspx?pDepartmentId=0&pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=490;width=650">
            
              <%# Eval("job_name") %>
            
            </a>
        </td>
        <td><a href="section_info.aspx?pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=490;width=650">
            
                >> Add Section >>
            
            </a>
        </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
         
       
           <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable themeContent">
             <tr>
                <th colspan="2" >Client with no Section</th>
                
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="NoSectionLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="NoSectionDataSource_Selecting">
      </asp:LinqDataSource>

      <br />

      <asp:ListView ID="NoConsultantListView" runat="server"
        DataSourceID="NoConsultantLinqDataSource">
        <ItemTemplate>
        <tr >
        <td>
        <%# Eval("job_name") %> 
        </td>
        <td>
            <a href="client_info_new.aspx?pDepartmentId=0&pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=490;width=650">
            
              >> Assign Consultant >> </font>
            
            </a>
        </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
         
       
           <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent">
           <tr>
                <th colspan="2" >Clients with no Consultant</th>
                
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="NoConsultantLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="NoConsultantDataSource_Selecting">
      </asp:LinqDataSource>



<%} %>
<br />
<asp:ListView ID="OverdueRemindersFormView" runat="server"
             DataSourceID="overdueRemindersLinqDataSource"
              DataKeyNames="id"
              OnItemUpdated="refreshPage">
        <ItemTemplate>
          <tr>          
              <td style="width:12.5em" nowrap >  <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> 
                    </td>
              <td width="50%" nowrap type="text"> <asp:Image ID="high_pri_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-high.png" />&nbsp   <%# Eval("reminder1")%></td>
              <td nowrap> <asp:Button ID="EditButton" runat="server" CommandName="Edit" style="width:18.75em;" Text=<%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%> /></td>
              
              <td width="5%" nowrap type="text"> 
              
              <a href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pUserName=<%# Eval("section.client.consultant_name") %>">  <%# Eval("section.client.consultant_name")%> </a>
              
              </td>  
              <td width="10%" nowrap type="text">
                  <%# Eval("department_id")%>
               <a  href="client_category_popup.aspx?pClientId=<%# Eval("section.client_id")%>" rel="shadowbox;height=500;width=800"> 
                                 <img src="Images/responses.png" title="client responses" />
        </a>       
       &nbsp&nbsp
              <a onclick="saveScroll()"  href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("section.client_id") %>" rel="shadowbox;height=500;width=700"> 
            <img src="Images/client_info.png" title="client info" />
        </a>&nbsp&nbsp
              <a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
           </tr>                      
        </ItemTemplate>
        <EditItemTemplate>
            <tr >
            <asp:Label Visible="false" runat="server" ID="clientNameLabel" Text='<%# Bind("section.client.job_name") %>' />
                    <asp:Label Visible="false" runat="server" ID="sectionLabel" Text='<%# Bind("section.section_name") %>' />
                   
                    
              <td nowrap> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td nowrap> <asp:Label  runat="server" ID="Label1" Text='<%# Bind("reminder1") %>' />
                <asp:CheckBox ID="CheckBox2" runat="server" Text="<img src='Images/priority-high.png' height='15px'/>" Checked='<%# Bind("high_priority") %>'  />
              </td>
              <td nowrap> <asp:TextBox  ID="datepicker" runat="server" 
                        Text='<%# Bind("reminder_due_date","{0:ddd, d MMM, yyyy}") %>' />
                  <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" CssClass="btn-large" />
                        <asp:Button ID="CancelButton" runat="server" Text="X" CommandName="Cancel">
                  </asp:Button>
<%--                  <span class="ui-icon ui-icon-circle-plus" style="height:20px; width:20px;"></span>--%>
              </td>
             
              <td> <%# Eval("section.client.consultant_name")%></td>  
              <td><a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
          </tr> 
        
        </EditItemTemplate>
        <LayoutTemplate>
          
            <table ID="itemPlaceholderContainer" class="themeContent" runat="server" border="0" width="50%">
             <tr>
                <th colspan="5" class="redrow">Overdue Tasks</th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>


<asp:LinqDataSource ID="overdueRemindersLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="overdueRemindersDataSource_Selecting"
                 EnableUpdate="True"
                 TableName="reminders">
                  
</asp:LinqDataSource>


<br />
<br />
<br />


<asp:ListView ID="TodaysListView" runat="server"
             DataSourceID="todayRemindersLinqDataSource"
             DataKeyNames="id"
              OnItemUpdated="refreshPage">
         <ItemTemplate>
          <tr >
              <td width="20%" nowrap>   <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> 
              </td>
              <td width="50%" nowrap><asp:Image ID="high_pri_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-high.png" />&nbsp   <%# Eval("reminder1")%></td>
              <td nowrap> <asp:Button ID="EditButton" runat="server" CommandName="Edit"  style="width:18.75em;" Text=<%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%> /></td>
              
              <td width="5%" nowrap> <a href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pUserName=<%# Eval("section.client.consultant_name") %>">  <%# Eval("section.client.consultant_name")%>   </a></td>  
              <td width="10%" nowrap>
                  <%# Eval("department_id")%>
               <a  href="client_category_popup.aspx?pClientId=<%# Eval("section.client_id")%>" rel="shadowbox;height=500;width=800"> 
                                 <img src="Images/responses.png" title="client responses" />
        </a>       
       &nbsp&nbsp
              <a onclick="saveScroll()"  href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("section.client_id")%>" rel="shadowbox;height=500;width=700"> 
            <img src="Images/client_info.png" title="client info" />
        </a>&nbsp&nbsp
              <a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
            
            
                       
          </tr>                      
        </ItemTemplate>
        <EditItemTemplate>
            <tr >
            <asp:Label Visible="false" runat="server" ID="clientNameLabel" Text='<%# Bind("section.client.job_name") %>' />
                    <asp:Label Visible="false" runat="server" ID="sectionLabel" Text='<%# Bind("section.section_name") %>' />
                    
              <td nowrap> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td nowrap>  <asp:Label  runat="server" ID="Label1" Text='<%# Bind("reminder1") %>' />
              <asp:CheckBox ID="CheckBox2" runat="server" Text="&nbsp;" Checked='<%# Bind("high_priority") %>'  /><img src="Images/priority-high.png" />
              </td>
              <td nowrap> <asp:TextBox  ID="datepicker" runat="server" 
                        Text='<%# Bind("reminder_due_date","{0:ddd, d MMM, yyyy}") %>' />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
              </td>
             
              <td nowrap> <%# Eval("section.client.consultant_name")%></font></t>  
              <td nowrap><a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
            
          </tr> 
             
        </EditItemTemplate>
        <LayoutTemplate>
          
            <table ID="itemPlaceholderContainer" class="tableSpacing paddedTable themeContent" runat="server" border="0" width="50%">
             <tr>
                <th colspan="5" class="greenrow" >Todays Tasks</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>       
</asp:ListView>


<asp:LinqDataSource ID="todayRemindersLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="todayRemindersDataSource_Selecting"
                 EnableUpdate="True"
                 TableName="reminders">
</asp:LinqDataSource>

<br />
<br />
<br />

<asp:ListView ID="nextListView" runat="server"
             DataSourceID="nextRemindersLinqDataSource"
             DataKeyNames="id"
              OnItemUpdated="refreshPage">
         <ItemTemplate>
                   
         
          
          <tr >
            
            
              <td width="20%"  nowrap> 
                          <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> 
                    </td>  
              <td width="50%" nowrap><asp:Image ID="high_pri_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-high.png" />&nbsp   <%# Eval("reminder1")%></td>
              <td nowrap> <asp:Button ID="EditButton" runat="server" CommandName="Edit"  style="width:18.75em;" Text=<%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%> /></td>
              
              <td width=100px nowrap> <a href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pUserName=<%# Eval("section.client.consultant_name") %>">  <%# Eval("section.client.consultant_name")%>   </a></td>  
              <td width=200px nowrap>
                  <%# Eval("department_id")%>
              <a  href="client_category_popup.aspx?pClientId=<%# Eval("section.client_id")%>" rel="shadowbox;height=500;width=800"> 
                                 <img src="Images/responses.png" title="client responses" />
        </a>       
       &nbsp&nbsp
              <a onclick="saveScroll()"  href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("section.client_id")%>" rel="shadowbox;height=500;width=700"> 
            <img src="Images/client_info.png" title="client info" />
        </a>&nbsp&nbsp
              <a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
          </tr>                      
        </ItemTemplate>
        <EditItemTemplate>
            <tr >
            <asp:Label Visible="false" runat="server"  ID="clientNameLabel" Text='<%# Bind("section.client.job_name") %>' />
                    <asp:Label Visible="false" runat="server" ID="sectionLabel" Text='<%# Bind("section.section_name") %>' />
                   
              <td nowrap> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td nowrap> <asp:Label  runat="server" ID="Label1" Text='<%# Bind("reminder1") %>' />
              <asp:CheckBox ID="CheckBox2" runat="server" text="<img src='Images/priority-high.png' height='15px'/>"  Checked='<%# Bind("high_priority") %>' style="padding-block:5px !important;" />
              </td>
              <td nowrap> <asp:TextBox  ID="datepicker" runat="server" 
                        Text='<%# Bind("reminder_due_date","{0:ddd, d MMM, yyyy}") %>' />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
              </td>
             
              <td nowrap> <%# Eval("section.client.consultant_name")%></font></td>  
              <td nowrap><a href="section_view.aspx?pReminderType=<%# Eval("type")%>&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>&pUserName=<%Response.Write(Page.Request.QueryString["pUserName"]); %>    ">Go to Task >></a></td>
          </tr> 
        </EditItemTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" class="tableSpacing paddedTable themeContent" runat="server" border="0"  width="50%">
             <tr>
                <th colspan="5" class="amberrow" >Next Tasks</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>       
</asp:ListView>


<asp:LinqDataSource ID="nextRemindersLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="nextRemindersDataSource_Selecting"
                 EnableUpdate="True"
                 TableName="reminders">
</asp:LinqDataSource>





</asp:Content>

