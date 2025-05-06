<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="sc_dashboard.aspx.cs" Inherits="sc_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">


   
<%--   define barWidth = <%= percentageTest()  %>;--%>
	<div>
		<h1> <strong>Site Coordinator </strong></h1>
		<p> Welcome <%  String userName = Context.User.Identity.Name;
								  Response.Write(userName);  %></p>
	</div>
	<br/>
<div style="margin-bottom:150px !important">
    <section class="bar-graph bar-graph-vertical bar-graph-two" >
  <div class="bar-one bar-container" style="margin-bottom: 40px;">
    <div class="bar" data-percentage="40%"></div>
    <span class="year">2019</span>
  </div>
  <div class="bar-two bar-container" style="margin-bottom: 40px;">
    <div id="bar2" class="bar" data-percentage="<%= percentageTest() %>%"></div>
    <span class="year">2018</span>
  </div>
  <div class="bar-three bar-container" style="margin-bottom: 40px;">
    <div class="bar" data-percentage="68%"></div>
    <span class="year">2017</span>
  </div>
  <div class="bar-four bar-container" style="margin-bottom: 40px;">
    <div class="bar" data-percentage="82%"></div>
    <span class="year">2016</span>
  </div>
</section>
</div>
    <br />
 
    
	<br />
<div>
    <section class="bar-graph bar-graph-horizontal bar-graph-one">
  <div class="bar-one" >
    <span class="year">2019</span>
    <div class="bar" data-percentage="89.6%" style="--perc:89.6%"></div>
  </div>
  <div class="bar-two">
    <span class="year">2018</span>
    <div id="bar2018" class="bar" data-percentage="<%= percentageTest() %>%"  ></div>
  </div>
  <div class="bar-three">
    <span class="year">2017</span>
    <div class="bar" data-percentage="74.7%"></div>
  </div>
  <div class="bar-four">
    <span class="year">2016</span>
    <div class="bar" data-percentage="48.6%"></div>
  </div>

</section>
	<br />
</div>
    <script>

        $(document).ready(function () {
            var width2018 = "<%= percentageTest() %>%";
            document.getElementById('bar2018').setAttribute("style", "width:" + width2018 + " !important")

        });

		$(document).ready(function () {
            var barHeight = "<%= percentageTest() %>%";
			document.getElementById('bar2').setAttribute("style", "height:" + barHeight + " !important")

		});


	</script>
</asp:Content>

