<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="my-data-graphs.aspx.cs" Inherits="my_data_graphs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
	<svg  width="1000" height="400">
		<g id="point" transform="translate(70, 250)"></g>
		<g id="leftaxis" transform="translate(70, 0)"></g>
		<g id="drawline"class="road"  transform="translate(70, 0)"></g>
		<g  transform="translate(400, 300)"> <text> Consultants</text></g>
		<g transform="translate(20, 200)"><text transform="rotate(-90)">Number of Won leads</text></g>
	</svg>


<div>

	<asp:TextBox runat="server" ID="txtSearch" />
    <asp:Button runat="server" ID="btnSearchBar" Style="background-color: #c9302c;" CssClass="btn btn-danger" Text="Search" OnClientClick="javascipt: return confirm('are you sure want to search ?');" OnClick="btnSearchBar_Click" />

</div>
<script>

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



	let scalepoint = d3.scalePoint()
		.domain(myData)
		.range([0, 800]);

	var data = [
		<%
	i = 0;
	int maxWon = 0;

	foreach(var c in consultants)
			{
				%>{ value: <%
	int won = wonLeadFromSetDateByCons(c);
	if (maxWon < won)
	{
		maxWon = won;
	}
 %> <%= won %> }<%
		if (i++ != consultants.Count() - 1)
				{
					%>,<%
				}
	}
	%>
	];


	let leftside = d3.scaleLinear()
		.domain([<%= maxWon +10 %>, 0])
		.range([0, 250]);

	var xScale = d3.scaleLinear().domain([0, <%= consultants.Count()-1 %>]).range([0, 800]);
	
	var lineGenerator = d3.line()
		.x(function (d, i) { return xScale(i); })
		.y(function (d) { return leftside(d.value); });


	var line = lineGenerator(data);

	let axisleft = d3.axisLeft();
   
	let axisbottom = d3.axisBottom();

	axisleft.scale(leftside);
	d3.select('#leftaxis').call(axisleft)

	axisbottom.scale(scalepoint);
	d3.select('#point').call(axisbottom);

	d3.select('#drawline')
		.append('path')
		.attr('d', line);

	var areaGenerator = d3.area().y0(250);

	var area = areaGenerator(data);
	d3.select('#areacreated')
		

</script>
</asp:Content>

