<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new_dir_dashboard.aspx.cs" Inherits="new_dir_dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           

<div>
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
		<br />

<div id="welcomeBanner">
    Welcome Sylvia

</div>
              
<br />
		<div id="currentProjects">
          <%--  <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Height="100" Width="300">

	<div>--%>	
        
        <asp:LinqDataSource ID="projectsInProgressLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="projectsInProgressDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="ProjectsInProgressFormView" runat="server"
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
              
</asp:ListView>
<%--</div>
</asp:TextBox>--%>
		</div>
        <br />
		<div id="alerts" style="border:1px solid gray;"><h1>ALERT</h1>
			<br />
			<p> Urgent Meeting : 10am.</p>
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
	</div>--%>
    <%--<br />
      <h1>&nbsp; &nbsp; KPIS</h1>--%>
	    <br />
    <div id="KPIS">KPIS</div>
  <div id="myNewKPIS">
      <%--<h1>KPIS 2 </h1>
      <br />--%>
      <div class="myConsultants"><img src="Images/allconsultants.png"  alt="allconsultants"/><br /> All Consultants -<%= numberOfConsultants() %>
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
<%--          </div>--%>
      </div>
      <div class="myWon">Won Since Jan-<%= wonLeadFromSetDate() %>
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
      </div>
      <div class="mysiteCo">SiteCo-<%=GetTotalAmountAllocated() %>
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
      </div>
      <div class="myProduction">Preproduction</div>
      <div class="myProduction">Production</div>
      <div class="myReminders  <%= (overdueRemindersCount()>0)?"myRems-red":"myRems-green" %>">Overdue Rems (<%=overdueRemindersCount() %>)</div>
  </div>
</div>


</div>
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
        
    </form>
</body>
</html>
