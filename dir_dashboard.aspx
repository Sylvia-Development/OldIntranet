<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="dir_dashboard.aspx.cs" Inherits="dir_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
<div >
    <div id="dialog" title="Basic dialog" style="display:none;" class="ui-front" >
        <a  href="client_info_new.aspx?pClientId=-1" ></a>
    </div>
</div>
    <%         
            String deptId = "1";
            String userName = "";
            String SCuserName = ""; // site coordinator name

            if (Context.User.IsInRole("Design Consultant") && !Context.User.IsInRole("Customer Experience Manager"))
            {
                deptId = "0";
                userName = Context.User.Identity.Name;
            }
            else if (Context.User.IsInRole("Customer Experience Manager"))
            {
                deptId = "6";

            }
            else if ( Context.User.IsInRole("Systems Integration") )
            {
                deptId = "1";

            }
            else if (Context.User.IsInRole("Site Coordinator") && !Context.User.IsInRole("Projects Director") )
            {
                deptId = "2";
                SCuserName = Context.User.Identity.Name;
            }
            else if (Context.User.IsInRole("Installer") && (!Context.User.IsInRole("Technical Services Manager") && !Context.User.IsInRole("Technical Services Technician1") && !Context.User.IsInRole("Technical Services Technician2")&& !Context.User.IsInRole("Technical Services Technician3")&& !Context.User.IsInRole("Technical Services Technician4") ))
            {
                deptId = "3";

            }
            else if (Context.User.IsInRole("Service Call Agent") )
            {
                deptId = "4";
            }
            else if (Context.User.IsInRole("Processing Assistant") )
            {
                deptId = "5";
            }
            else if (Context.User.IsInRole("Projects Director"))
            {
                deptId = "7";
            }
            else if (Context.User.IsInRole("Technical Services Manager"))
            {
                deptId = "8";
            }
            else if (Context.User.IsInRole("Finance Director"))
            {
                deptId = "9";
            }
            else if (Context.User.IsInRole("Finance Admin Administrator"))
            {
                deptId = "10";
            }
            else if (Context.User.IsInRole("Finance Admin Manager"))
            {
                deptId = "11";
            }
            else if (Context.User.IsInRole("Technical Administrator"))
            {
                deptId = "12";
            }
            else if (Context.User.IsInRole("Production Team Coordinator") || Context.User.IsInRole("Assembly Captain")|| Context.User.IsInRole("Assembly Team"))
            {
                deptId = "13";
            }
            else if (Context.User.IsInRole("Finishes Coordinator"))
            {
                deptId = "14";
            }
            else if (Context.User.IsInRole("Design Administrator"))
            {
                deptId = "15";
            }
            else if (Context.User.IsInRole("Technical Services Technician1"))
            {
                deptId = "16"; //Spare

            }
            else if (Context.User.IsInRole("Technical Services Technician2"))
            {
                deptId = "17";//Des

            }
            else if (Context.User.IsInRole("Technical Services Technician3"))
            {
                deptId = "18";//spare

            }
            else if (Context.User.IsInRole("Technical Services Technician4"))
            {
                deptId = "19";//spare

            }
            else if (Context.User.IsInRole("Technical Plan Generation Head"))
            {
                deptId = "20";//Jose

            }
            else if (Context.User.IsInRole("Operations Manager"))
            {
                deptId = "21";//Michelle

            }
            else if (Context.User.IsInRole("Procurement Coordinator"))
            {
                deptId = "22";//Twilla

            }
            else { deptId = "1"; }


            /*Assembly Captain
             Assembly Team
             Dispatch Transport Manager
             Finishes Captain
             Finishes Team
             Machining Captain
             Machining Team*/

            %>
<%--<div>
	<div id="myDIV">
		<div id="blackBanner">
			 <a  href="reminders_dashboard.aspx" title="Reminders"> 
                       <img src="Images/reminder.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Reminders</h3>
			<br />
			<br />
			<a  href="Default3.aspx" title="DashBoards"> 
                       <img src="Images/dashboard.png" style="padding:5px"/>
                </a>
			<br />
			<h3>DashBoard</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Setup"> 
                       <img src="Images/setup.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Setup</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/knowledge.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Knowledge Base</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/logout.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Placeholder</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/logout.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Logout</h3>
			<br />
		</div>
		<br />--%>
    <%--<div id="myBlackBanner">
		<a  href="reminders_dashboard.aspx" title="Reminders"> 
                       <img src="Images/reminder.png" />
                </a>
			<br />
			<h3>Reminders</h3>
			<br />
			<br />
		<a  href="Default3.aspx" title="DashBoards"> 
                       <img src="Images/dashboard.png" style="padding:5px"/>
                </a>
			<br />
			<h3>DashBoard</h3>
			<br/ >
			<br/ >
			<a  href="setup_default_reminders_users.aspx" title="Setup"> 
                       <img src="Images/setup.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Setup</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/knowledge.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Knowledge Base</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/logout.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Placeholder</h3>
			<br />
			<br />
			<a  href="setup_default_reminders_users.aspx" title="Logout"> 
                       <img src="Images/logout.png" style="padding:5px"/>
                </a>
			<br />
			<h3>Logout</h3>
			<br />
		</div>
		<br />
	--%>
<%--  <div style="display:flex; margin:10px 0px 0px 0px;">  	
    <div class="icon-bar">
    <a href="#" class="bluHome"><img src="Images/Blu-line_Logo2.jpg"/></a>
        <hr style="3px solid black;" />--%>
<%--    <div style="display:flex"><nav><%--<input id="txtSearch" style="background-color:white;padding:0px; height:54px" class="ui-autocomplete-input" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true" type="text"  placeholder="search name..." />--%><%--<img src="Images/search.png" style="padding:10px;"/>--%>
 <%--       <input id="txtSearch" style="background-color:white;padding:0px; height:54px" class="bluSearch" type="text"  placeholder="search name..." />
            <div id="results"></div>
        </nav>
        </div>--%>
<%--     <input id="txtSearch" class="bluSearch" <%-- style="background-color:white; padding-top:7px; margin:0px; display:flex; width:180px"--%> <%--type="text"  placeholder="search name..." />--%>
<%--         <%    if (Context.User.IsInRole("AdvancedSearch"))
            { %> <a style="display:flex;"  href="advanced_search_page.aspx" title="Go To Advanced Search Page"> <img src="Images/search.png"/> </a> 
        <%} %> 
        
        <div id="results"></div> 
      
    <a href="#company" class="designMenu">Design</a>
        <div class="sub-icon-bar">
            <div class="designSub">
             <ul>
                      <%if( Context.User.IsInRole("Director")
                         || Context.User.IsInRole("Design Consultant")
                         || Context.User.IsInRole("Design Administrator")
                         || Context.User.IsInRole("Systems Integration")
                         || Context.User.IsInRole("Technical Services Technician3")){ %>  
                     
	                     <li> <a href="client_info_new.aspx?pClientId=-1" rel="shadowbox;height=500;width=700">new client</a></li> 
	                 
	                  <% }  %>  


                      <%  if( Context.User.IsInRole("Director")
                           || Context.User.IsInRole("Design Consultant")
                           || Context.User.IsInRole("Design Administrator")
                           || Context.User.IsInRole("Systems Integration")){ %>   
	                 
	                    <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=maincrm">crm</a> </li> 
	                
	                  <% }  %>

                             <%  if( Context.User.IsInRole("Twelve")){ %>   
	                 
	                    <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=maincrm&pUserName=ashley">ashley crm</a> </li> 
                        <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=maincrm&pUserName=ezio">ezio crm</a> </li> 
	                
	                  <% }  %>
                             <%  if( Context.User.IsInRole("OCD")){ %>   
	                 
	                    <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=maincrm&pUserName=craig">craig crm</a> </li> 
                        <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=maincrm&pUserName=des">des crm</a> </li> 
	                
	                  <% }  %>
                            

                              <%  if( Context.User.IsInRole("Director") 
                                     || Context.User.IsInRole("Customer Experience Manager")
                                     || Context.User.IsInRole("Design Administrator")
                                     || Context.User.IsInRole("Systems Integration")){
                                 
                                 %> 
	                 
	                        <li> <a href="time_management_data.aspx?pDepartmentId=0">capture time</a></li> 
	                 
	                     <% } %>



                        <%  if( Context.User.IsInRole("Director")){ %>   
	                 
	                <li> <a href="design_management.aspx">management</a> </li> 
                    <li> <a href="design_management.aspx">cem management</a> 
                        <ul>
                            <li> <a href="reminders_dashboard.aspx?pDepartmentId=6">cem reminders</a> </li> 
                            <li> <a href="section_view.aspx?pClientName=Showroom%20CEM&pSectionId=1637&pClientId=1408&pDepartmentId=6">showroom tasks</a> </li> 


                        </ul>

                    </li> 
	                
	                  <% }  %>
                      <%  if( Context.User.IsInRole("Director")
                           || Context.User.IsInRole("Design Consultant")
                           || Context.User.IsInRole("Design Administrator")
                           || Context.User.IsInRole("Systems Integration")){ %>   
	                 
	                    <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=marketing">marketing leads</a> </li> 
	                
	                  <% }  %>
                      <%  if( Context.User.IsInRole("Director")
                           || Context.User.IsInRole("Design Consultant")
                           || Context.User.IsInRole("Design Administrator")
                           || Context.User.IsInRole("Systems Integration")){ %>   
	                 
	                    <li> <a href="management_dashboard.aspx?pDepartmentId=0&pSectionFilter=completed">completed projects</a> </li> 
	                
	                  <% }  %>
                      <% if( Context.User.IsInRole("Director")
                          || Context.User.IsInRole("Design Consultant")
                          || Context.User.IsInRole("Design Administrator")
                          || Context.User.IsInRole("Systems Integration")){ %>     
                  
	                    <li>  <a href="archived_clients.aspx?pDepartmentId=0">archived clients</a></li> 
	                 
	                  <% } %>
                     
                         </ul>
          </div>             
        </div>
        <a href="#" class="productionMenu">Production</a>
        <div class="sub-icon-bar">
            <div class="productionSub">
                              <ul>
                            <%    if (Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")                                                                     
                                    || Context.User.IsInRole("Production Controller")
                                    || Context.User.IsInRole("Procurement Coordinator")
                                    || Context.User.IsInRole("Processing Assistant")
                                    || Context.User.IsInRole("Operations Manager")
                                    || Context.User.IsInRole("Technical Services Manager")
                                    || Context.User.IsInRole("Site Coordinator")
                                    || Context.User.IsInRole("Systems Integration")
                                    || Context.User.IsInRole("Technical Plan Generation Head"))
                                 { %>  
                            <li> <a href="urgent_orders.aspx">site orders</a> </li> 
                           

                            <%} %> 
                            
                            <%    if (Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")                                                                       
                                    || Context.User.IsInRole("Production Controller")
                                    || Context.User.IsInRole("Procurement Coordinator")
                                    || Context.User.IsInRole("Processing Assistant")
                                    || Context.User.IsInRole("Operations Manager")
                                    || Context.User.IsInRole("Technical Services Manager")
                                    || Context.User.IsInRole("Site Coordinator")
                                    || Context.User.IsInRole("Systems Integration")
                                    || Context.User.IsInRole("Technical Plan Generation Head"))
                                 { %>  
                            <li> <a href="production_management.aspx">production management</a> </li> 
                            <li> <a href="production_complete.aspx">production complete</a> </li> 
                            <li> <a href="logistics_control.aspx">logistics control</a> </li> 
                            <li> <a href="logistics_control_completed.aspx">completed deliveries</a> </li> 
                            <%} %>
                             <%     if( Context.User.IsInRole("Director")
                                     || Context.User.IsInRole("Projects Director")  
                                 || Context.User.IsInRole("Production Controller")
                                 || Context.User.IsInRole("Procurement Coordinator")
                                 || Context.User.IsInRole("Technical Services Manager")
                                 || Context.User.IsInRole("Operations Manager")
                                 || Context.User.IsInRole("Site Coordinator")
                                 || Context.User.IsInRole("Systems Integration")
                                 || Context.User.IsInRole("Technical Plan Generation Head"))
                                { %>  
	                 
	                            <li><a href="plan_generation.aspx">plan generation</a> </li> 
                            <li><a href="plan_generation_complete.aspx">plan generation complete</a> </li> 
	                 
	                        <% } %>
                            
                            <%     if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                 || Context.User.IsInRole("Production Controller")
                                 || Context.User.IsInRole("Procurement Coordinator")
                                 || Context.User.IsInRole("Technical Services Manager")
                                 || Context.User.IsInRole("Operations Manager")
                                || Context.User.IsInRole("Site Coordinator")
                                 || Context.User.IsInRole("Systems Integration")
                                 || Context.User.IsInRole("Technical Plan Generation Head"))
                                { %>  
	                 
	                            <li><a href="orders_management.aspx">supplier orders</a> </li> 
	                 
	                        <% } %>
                             
	                 
	                          
                           
                             <%     if( Context.User.IsInRole("Director")
                                     || Context.User.IsInRole("Projects Director")                                                                
                                    || Context.User.IsInRole("Processing Manager")
                                    || Context.User.IsInRole("Procurement Coordinator")                                   
                                    || Context.User.IsInRole("Production Controller")
                                    || Context.User.IsInRole("Production Manager")
                                    
                                   ){ %> 
	                                <li> <a href="technical_services.aspx?pDepartmentId=<%Response.Write(deptId);  %>">site order auth</a> </li>
                            
	                                
	                 
	                        <% }  %>
                     
                        </ul>
            </div>
        </div>
<a href="#" class="projectsMenu">Projects</class=""></a>
        <div class="sub-icon-bar">
            <div class="projectsSub">
                <ul>
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director") ) { %> 
	                 
	                        <li> <a href="sc_allocation_admin.aspx">SC Allocation</a> </li>
                             <li> <a href="sc_allocation_admin_completed.aspx">SC Allocation - Completed</a> </li>
                            
                            
                            
                            <% } %>
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Operations Manager")
                                    || Context.User.IsInRole("Procurement Coordinator")
                                      || Context.User.IsInRole("Technical Services Manager")
                                      || Context.User.IsInRole("Production Manager")
                                      || Context.User.IsInRole("Operations Manager")
                                      || Context.User.IsInRole("Production Controller")
                                      || Context.User.IsInRole("Site Coordinator")
                                      || Context.User.IsInRole("Systems Integration")
                                      || Context.User.IsInRole("Technical Plan Generation Head")) { %> 
	                 
	                        <li> <a href="management_dashboard.aspx?pDepartmentId=2&pSectionFilter=maincrm">projects crm</a> </li>
                            <li> <a href="project_dates.aspx?pDepartmentId=2">project dates</a> </li>
                            <li> <a href="installation_times.aspx?pDepartmentId=<%Response.Write(deptId);  %>">installation times</a> </li>
                            
                            
                            <% } %>
                            
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Operations Manager")
                                   || Context.User.IsInRole("Production Manager")
                           
                                   || Context.User.IsInRole("Production Controller")
                                   || Context.User.IsInRole("Technical Services Manager")
                                   || Context.User.IsInRole("Site Coordinator")
                                   || Context.User.IsInRole("Systems Integration")
                                   || Context.User.IsInRole("Technical Plan Generation Head")){ %> 
	                 
	                        <li> <a href="management_dashboard.aspx?pDepartmentId=4&pSectionFilter=maincrm">service call crm</a> </li> 
	                 
	                        <% } %>
                             <%    if( Context.User.IsInRole("Director")
                                     || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Operations Manager")
                                   || Context.User.IsInRole("Production Manager")
                                   || Context.User.IsInRole("Finance Admin Manager")
                                   || Context.User.IsInRole("Site Coordinator")
                                   || Context.User.IsInRole("Systems Integration")
                                   || Context.User.IsInRole("Technical Plan Generation Head")){ %> 
	                 
	                        <li> <a href="management_dashboard.aspx?pDepartmentId=10&pSectionFilter=maincrm">finance admin crm</a> </li> 
	                 
	                        <% } %>
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Systems Integration")
                                   || Context.User.IsInRole("Operations Manager")
                                   || Context.User.IsInRole("Customer Experience Manager")
                                   || Context.User.IsInRole("Technical Plan Generation Head"))
                                  { %> 
	                 
	                        <li> <a href="reminders_dashboard.aspx?pDepartmentId=2">projects reminders </a> </li> 
	                 
	                        <% } %>
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Technical Services Manager")
                                   || Context.User.IsInRole("Operations Manager")
                                   || Context.User.IsInRole("Production Manager")
                                   || Context.User.IsInRole("Production Controller")
                                      || Context.User.IsInRole("Finance Admin Manager")
                                      || Context.User.IsInRole("Site Coordinator")
                                      || Context.User.IsInRole("Systems Integration"))
                                  { %> 
	                 
	                        <li> <a href="management_dashboard.aspx?pDepartmentId=2&pSectionFilter=completed">completed projects</a> </li> 
	                 
	                        <% } %>
                            <%    if( Context.User.IsInRole("Director")
                                    || Context.User.IsInRole("Projects Director")  
                                   || Context.User.IsInRole("Project Manager")
                                   || Context.User.IsInRole("Operations Manager")
                                   || Context.User.IsInRole("Production Manager")
                                   || Context.User.IsInRole("Production Controller")
                                   || Context.User.IsInRole("Technical Services Manager")
                                   || Context.User.IsInRole("Site Coordinator")
                                   || Context.User.IsInRole("Systems Integration")
                                   || Context.User.IsInRole("Technical Plan Generation Head")){ %> 
	                 
	                        <li> <a href="management_dashboard.aspx?pDepartmentId=4&pSectionFilter=completed">completed service's</a> </li> 
	                 
	                        <% } %>
                     
                         </ul>
            </div>
        </div>
  <a href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(deptId);  %>&pUserName=<%Response.Write(userName); %>&pSCUserName=<%Response.Write(SCuserName); %>">
      <i class="icon-tasks"><br />Reminders</i>

  </a>
        
  <a href="#"><i class="icon-dashboard"><br />Dashboard</i></a> 
       <div>
           <div class="dashboardSub">
       <div class="sub-icon-bar">
           
      <a href="#company">Directors</a>
      <a href="#team">Consultants</a>
      <a href="#careers">SiteCo</a>
        </div>
    </div>
            </div>
  <a href="blu_line_academy.aspx"><i class="icon-book"><br /></i>Academy</a> 
  <a href="#"><i class="icon-gear"></i><br />Setup</a>
  <a href="#"><i class="icon-signout"><br />Signout</i></a> 
</div>--%>

<%--<div class="myContent">
     <div id="alerts" style="border:1px solid gray;"><h1>ALERT</h1>
			<br />
			<p> Urgent Meeting : 10am.</p>
		</div>
   
<div id="welcomeBanner">
    Welcome Sylvia

</div>
   <div id="myTodoList">
			<br />
		<asp:ListView ID="TodoListView" runat="server"
             DataSourceID="todoRemindersLinqDataSource"
             DataKeyNames="id">
         <ItemTemplate> 
          <tr >
            
              <td nowrap>   <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td nowrap><asp:Image ID="high_pri_image" Visible='<%# Eval("high_priority") %>' runat="server" ImageUrl="Images/priority-high.png" />&nbsp   <%# Eval("reminder1")%></td>
              <td nowrap> <asp:Button ID="EditButton" runat="server" CommandName="Edit" Width="200px" Text=<%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%> /></td>            
                       
          </tr>                      
        </ItemTemplate>
        
        <LayoutTemplate>       
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" width="500px">
             <tr class="myTodoheaders" >
                <th colspan="5" >My To do List</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>       
</asp:ListView>
<asp:LinqDataSource ID="todoRemindersLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="todoRemindersDataSource_Selecting"                
                 TableName="reminders">
</asp:LinqDataSource>
</div>           
<br />
		<div id="currentProjects">
          <%--  <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Height="100" Width="300">

	<div>--%>	
        
<%--        <asp:LinqDataSource ID="projectsInProgressLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="projectsInProgressDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> --%>
<%--<asp:ListView ID="ProjectsInProgressFormView" runat="server"
             DataSourceID="projectsInProgressLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
          
          <tr>
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font></td>
              <td><font color="black"> <%# Eval("section.client.consultant_name")%> </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("started_date"),System.DateTime.Now,0)%></font></td>
             <td class="<%# GetColorCode(Eval("started_date"),Eval("completed_date"), null, 0)=="Ontime"?"ontime":"behindtime"%>"><font color="black"> <%# GetColorCode(Eval("started_date"),Eval("completed_date"), null, 0)=="Ontime"?"Ontime":"Behind Schedule"%> </font></td>
                       
          </tr>                      
        </ItemTemplate>
       <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1">
             <tr  class="myheaders">
                <th colspan="4" ><font color="black">Projects In Progress</font> </th>
                
                </tr>
                <tr>
                    <td>
                        No Designs To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" width="1000px">
             <tr  class="myheaders">
                <th colspan="4" >Designs In Progress</th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>

            </table>
            </LayoutTemplate>
              
</asp:ListView>--%>
<%--</div>
</asp:TextBox>--%>
<%--		</div>--%>
<%--    <div id="myNewKPIS" style="display:flex">
      <%--<h1>KPIS 2 </h1>
      <br />--%>
<%--      <div class="myConsultants"><img src="Images/allconsultants.png" style="padding:10px"/><br /> All Consultants -<%= numberOfConsultants() %>
          <div class="myConsultantsRibbon" style="display:none">
              <asp:ListView ID="consultantsListView" runat="server"
             DataSourceID="consultantsLinqDataSource"
              DataKeyNames="ID" >
        <ItemTemplate>
          <tr> <td  style="font-size:12px" nowrap>  <%# Eval("aspnet_User.UserName")%> </td>  
              <td style="font-size:12px" nowrap><a href="dc_dashboard.aspx?pUserName=<%# Eval("aspnet_User.UserName")%> ">Consultant Dashboard >></a></td>           
          </tr>                      
        </ItemTemplate>
        <LayoutTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0">
               <tr>
                    <th colspan="5" ></th>
               </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
<asp:LinqDataSource ID="consultantsLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="allConsultantsOnSelecting"
                 EnableUpdate="False"
                 TableName="consultant_allocations_news"/>

	</div>
</div>    --%>
<%--      <div class="myWon"><img  class="wonPng" src="Images/leads.png"/><br />Won Since Jan-<%= wonLeadFromSetDate() %>
          <div class="myWonRibbon" style="display:none">
              <asp:ListView ID="ConsultantAllocationListView" runat="server" DataKeyNames="ID" 
        DataSourceID="ConsultantsDataSource" > 
        <ItemTemplate>      
           <tr >
                <td style="font-size:12px" nowrap><%# Eval("aspnet_User.UserName")%></td> 
                <td style="font-size:12px" align="center" nowrap> <%# wonLeadFromSetDateByCons((String) Eval("aspnet_User.UserName")) %></td> 
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" >
                            <tr>  
                                <td  align="center" id="itemplaceholder1" runat="server"></td>
                                <td  align="center" id="ITemplaceholder" runat="server" ></td>
                            </tr>
                        </table>
      </LayoutTemplate>     
    </asp:ListView>
    <asp:LinqDataSource ID="ConsultantsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="consultant_allocations_new"
        OnSelecting="all_consultants_onSelecting">
    </asp:LinqDataSource>
          </div>
      </div>--%>
<%--      <div class="mysiteCo"><img  class="wonPng" src="Images/siteCos.png"/><br />SiteCo-<%=GetTotalAmountAllocated() %>
        <div class="mysiteCoRibbon" style="display:none">
<asp:ListView ID="AllocationValueListView" runat="server"
        DataSourceID="AllocationValueLinqDataSource">
        <ItemTemplate>
        <tr >
        <td nowrap><%# Eval("UserName") %></td>
        <td nowrap> <%# GetAmountAllocated(Eval("UserName"))%> </td>
        </tr>    
        </ItemTemplate>
          <LayoutTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0">
                <tr ID="itemPlaceholder" runat="server">                

                </tr>
            </table>
            </LayoutTemplate>
      </asp:ListView>
      <asp:LinqDataSource ID="AllocationValueLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="AllocationValueLinqDataSource_Selecting">
      </asp:LinqDataSource>
        </div>
      </div>--%>
    <%--  <div class="myProduction">Preproduction</div>
      <div class="myProduction">Production</div>
      <div class="myReminders  <%= (overdueRemindersCount()>0)?"myRems-red":"myRems-green" %>">Overdue Rems (<%=overdueRemindersCount() %>)</div>
        </div>--%>

        <br />
<%--	--%>	

		

<br />
<%--<div id="myKPIS">
			<h1>&nbsp; &nbsp; KPIS</h1>
			<br />

		

	<div class='steps-container'>
  <div class='steps active'>
    <span >All Consultants -<%= numberOfConsultants() %></span>
  </div>
  <div class='steps won'>
    <span>Won Since Jan-<%= wonLeadFromSetDate() %></span>
  </div>
  <div class='steps preproduction'>
    <span>SiteCo-<%=GetTotalAmountAllocated() %></span>
  </div>
  <div class='steps production'>
    <span>Step 4</span>
  </div>
  <div class='steps installation'>
    <span>Step 5</span>
  </div>  
  <div class='steps <%= (overdueRemindersCount()>0)?"reminders-red":"reminders" %>'>
    <span >Overdue Rems (<%=overdueRemindersCount() %>) </span>
  </div>    
</div>


<%--<div class="containerbox">
	<div class="activebox" style="font-size:8px">
		<asp:ListView ID="consultantsListView" runat="server"
             DataSourceID="consultantsLinqDataSource"
              DataKeyNames="ID" >
        <ItemTemplate>
          <tr> <td  style="font-size:12px" nowrap>  <%# Eval("aspnet_User.UserName")%> </td>  
              <td style="font-size:12px" nowrap><a href="dc_dashboard.aspx?pUserName=<%# Eval("aspnet_User.UserName")%> ">Consultant Dashboard >></a></td>           
          </tr>                      
        </ItemTemplate>
        <LayoutTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0">
               <tr>
                    <th colspan="5" ></th>
               </tr>
                <tr ID="itemPlaceholder" runat="server">
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
<asp:LinqDataSource ID="consultantsLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="allConsultantsOnSelecting"
                 EnableUpdate="False"
                 TableName="consultant_allocations_news"/>

	</div>
	<div class="wonbox"><asp:ListView ID="ConsultantAllocationListView" runat="server" DataKeyNames="ID" 
        DataSourceID="ConsultantsDataSource" > 
        <ItemTemplate>      
           <tr >
                <td style="font-size:12px" nowrap><%# Eval("aspnet_User.UserName")%></td> 
                <td style="font-size:12px" align="center" nowrap> <%# wonLeadFromSetDateByCons((String) Eval("aspnet_User.UserName")) %></td> 
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" >
                            <tr>  
                                <td  align="center" id="itemplaceholder1" runat="server"></td>
                                <td  align="center" id="ITemplaceholder" runat="server" ></td>
                            </tr>
                        </table>
      </LayoutTemplate>     
    </asp:ListView>
    <asp:LinqDataSource ID="ConsultantsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="consultant_allocations_new"
        OnSelecting="all_consultants_onSelecting">
    </asp:LinqDataSource>
    </div>
	<div class="preproductionbox">
        <asp:ListView ID="AllocationValueListView" runat="server"
        DataSourceID="AllocationValueLinqDataSource">
        <ItemTemplate>
        <tr >
        <td nowrap><%# Eval("UserName") %></td>
        <td nowrap> <%# GetAmountAllocated(Eval("UserName"))%> </td>
        </tr>    
        </ItemTemplate>
          <LayoutTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0">
                <tr ID="itemPlaceholder" runat="server">                

                </tr>
            </table>
            </LayoutTemplate>
      </asp:ListView>
      <asp:LinqDataSource ID="AllocationValueLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="AllocationValueLinqDataSource_Selecting">
      </asp:LinqDataSource>

	</div>
	<div class="productionbox"></div>
	<div class="installationbox"></div>
	<div class="remindersbox"> <%= getOverdueConsultants() %></div>
</div>--%>
<%--	</div>--%>
    <%--<br />
      <h1>&nbsp; &nbsp; KPIS</h1>--%>
<%--	    <br />
    <div id="KPIS">KPIS</div>--%>
  
<%--          </div>--%>
<%--</div>--%>


<%--</div>--%>
<%--<br />--%>
<%--label for="height">Change Height:</label>
<input id="height" class="slider" type="range" value="8" min="30" max="100" title="Adjust slider to increase or decrease height"/>
<br />--%>
 <%--   <h1 margin-top="10px">Won Leads per consultant</h1>
 <br />--%>


<%--	<svg width="760" height="140">
  <g class="bars" transform="translate(70, 30)"></g>
  <g class="labels" transform="translate(66, 30)"></g>
</svg>--%>

<%--<section class="bar-graph bar-graph-vertical bar-graph-two">
  <div class="bar-one bar-container">
    <div class="bar" data-percentage="<%= wonLeadFromSetDateByCons("des") %>"></div>
    <span class="year">des</span>
  </div>
  <div class="bar-two bar-container">
    <div class="bar" data-percentage="<%= wonLeadFromSetDateByCons("consultant1") %>"></div>
    <span class="year">consultant1</span>
  </div>
  <div class="bar-three bar-container">
    <div class="bar" data-percentage="<%= wonLeadFromSetDateByCons("consultant2") %>"></div>
    <span class="year">consultant2</span>
  </div>
  <div class="bar-four bar-container">
    <div class="bar" data-percentage="<%= wonLeadFromSetDateByCons("consultant3") %>"></div>
    <span class="year">consultant3</span>
  </div>
</section>--%>
<br />
   <script>
		$(document).ready(function () {
			adjustBar();
			$(window).on('resize', function () {
				adjustBar();
			})
			$('#height').on('input change', function () {
				var height = $(this).val();
				if (height >= 50) {
					var leftOffset = (Math.tan(45 * (Math.PI / 180)) * (height / 2) + 3) * -1;
					$('.steps').css('height', height).css('line-height', height + "px").css('left', leftOffset + "px");
					adjustBar();
				}
			});
			//$('.steps').on('click', function () {
			//	$('.steps').removeClass('active');
			//	$(this).addClass('active');
			//})
		});

		function adjustBar() {
			var items = $('.steps').length;
			var elHeight = $('.steps').height() / 2; //Division by 2 because each pseudo which is skewed is only 50% of its parent.
			var skewOffset = Math.tan(45 * (Math.PI / 180)) * elHeight;
			var reduction = skewOffset + ((items - 1) * 4);
			var leftOffset = $('.steps').css('left').replace('px', '');
			var factor = leftOffset * (-1) - 2;
			$('.steps').css({
				'width': '-webkit-calc((100% + 4px - ' + reduction + 'px)/' + items + ')',
				'width': 'calc((100% + 4px - ' + reduction + 'px)/' + items + ')'
			}); // 4px for borders on either side
			$('.steps:first-child, .steps:last-child').css({
				'width': '-webkit-calc((100% + 4px - ' + reduction + 'px)/' + items + ' + ' + factor + 'px)',
				'width': 'calc((100% + 4px - ' + reduction + 'px)/' + items + ' + ' + factor + 'px)'
			}); // 26px because to make up for the left offset. Size of last-child is also increased to avoid the skewed area on right being shown  
			$('.steps span').css('padding-left', (skewOffset + 15) + "px");
			$('.steps:first-child span, .steps:last-child span').css({
				'width': '-webkit-calc(100% - ' + factor + 'px)',
				'width': 'calc(100% - ' + factor + 'px)',
			});
        }


		//$('.steps.active').on('click', function () {
		//	$('.activebox').slideToggle("slow");
		//});
		//$('.steps.won').on('click', function () {
		//	$('.wonbox').slideToggle("slow");
		//});
		//$('.steps.preproduction').on('click', function () {
		//	$('.preproductionbox').slideToggle("slow");
		//});
		//$('.steps.production').on('click', function () {
		//	$('.productionbox').slideToggle("slow");
		//});
		//$('.steps.installation').on('click', function () {
		//	$('.installationbox').slideToggle("slow");
		//});
  //      $('.steps.reminders').on('click', function () {
		//	$('.remindersbox').slideToggle("slow");
  //      });

		//$('.steps.reminders-red').on('click', function () {
		//	$('.remindersbox').slideToggle("slow");
		//});
	   //$('.myConsultants'). {
		  // $('.myConsultantsRibbon').hide;
	   //});
       $('.myConsultants').on('click', function () {
		   $('.myConsultantsRibbon').slideToggle("slow");
		});
		$('.myWon').on('click', function () {
			$('.myWonRibbon').slideToggle("slow");
		});
		$('.mysiteCo').on('click', function () {
			$('.mysiteCoRibbon').slideToggle("slow");
		});
		$('.myProduction').on('click', function () {
			$('.myProductionRibbon').slideToggle("slow");
		});
		
        $('.myReminders').on('click', function () {
			$('.myRemindersRibbon').slideToggle("slow");
        });

		$('.myReminders-red').on('click', function () {
			$('.remindersbox').slideToggle("slow");
        });

       $('.dashboardSub').hide();
       $('.designSub').hide();
       $('.productionSub').hide();
       $('.projectsSub').hide();
	   $('.icon-dashboard').on('click', function () {
		   $('.dashboardSub').toggle(200);
       });

	   $('.designMenu').on('click', function () {
		   $('.designSub').toggle(200);
       });

	   $('.productionMenu').on('click', function () {
		   $('.productionSub').toggle(200);
       });

       $('.projectsMenu').on('click', function () {
           $('.projectsSub').toggle(200);
       });
   </script>
    <%--<script>
		var cities = [
			{ name: 'London', population: 8674000 },
			{ name: 'New York', population: 8406000 },
			{ name: 'Sydney', population: 4293000 },
			{ name: 'Paris', population: 2244000 },
			{ name: 'Beijing', population: 11510000 }
		];

		<%
	IntranetDataDataContext db = new IntranetDataDataContext();

	var consultants = (from c in db.consultant_allocations_news
					   select c.aspnet_User.UserName);
	%>
		var myData = [<%
	int i = 0;
	foreach(var c in consultants)
	{
				%>'<%= c %>'<% 
		if (i++ != consultants.Count() - 1)
				{
					%>,<%
				}
	}
	%>];

		// Join cities to rect elements and modify height, width and position
		d3.select('.bars')
			.selectAll('line')
			.data(cities)
			.join('rect')
			.attr('height', 19)
			.attr('width', function (d) {
				var scaleFactor = 0.00004;
				return d.population * scaleFactor;
			})
			.attr('y', function (d, i) {
				return i * 20;
			});

		// Join cities to text elements and modify content and position
		d3.select('.labels')
			.selectAll('text')
			.data(cities)
			.join('text')
			.attr('y', function (d, i) {
				return i * 20 + 13;
			})
			.text(function (d) {
				return d.name;
			});


	</script>--%>
</asp:Content>

