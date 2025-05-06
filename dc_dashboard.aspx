<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="dc_dashboard.aspx.cs" Inherits="dc_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
<div>

<div class="tests xlabel">
    
    <svg width="100%" height="500">
  <g id="wrapper" transform="translate(10, 470)" stroke="black"></g>
  <g id="left" transform="translate(30, 40)" stroke="black"></g>
  <g id="road" transform="translate(30, 40)"></g>
  
</svg>


</div>
</div>
<script>

 //   var width = 700, height = 400;

 ////   var data = ['Jan', 'Feb','March','April'];

 ////   var domdata = d3.domdata(data);
	//var svg = d3.select(".tests")
	//	.append("svg")
	//	.attr("width", width)
	//	.attr("height", height);

	////var xscale = d3.scaleLinear()
	////	.domain(data)
	////	.range(['black']);

	//var yscale = d3.scaleLinear()
	//	.domain([0, d3.max(data)])
	//	.range([height / 2, 0]);

	//var x_axis = d3.axisBottom()
	//	.scale(xscale);

	//var y_axis = d3.axisLeft()
	//	.scale(yscale);

	//svg.append("g")
	//	.attr("transform", "translate(50, 10)")
	//	.call(y_axis);

	//var xAxisTranslate = height / 2 + 10;

	//svg.append("g")
	//	.attr("transform", "translate(50, " + xAxisTranslate + ")")
	//	.call(x_axis)

	//var myData = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
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
    //var myInfo = [<=maConsultants()%>]
    //var count = <%=countmMaConsultants()%>;
    var count = <%= consultants.Count() %>;
	var linearScale = d3.scaleLinear()
		.domain([0, 15])
		.range([0, 1400]);

	var ordinalScale = d3.scaleOrdinal()
		.domain(myData)
		.range(['black', 'blue', 'green']);
		

     
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


	let scale = d3.scaleLinear().domain([<%= maxWon %>, 0]).range([0, 400]);

	let axisLeft = d3.axisLeft(scale);
	d3.select('#left').call(axisLeft);

	d3.select('#wrapper')
		.selectAll('text')
		.data(myData)
		.join('text')
		.attr('x', function (d, i) {
			return linearScale(i);
		})
		.text(function (d) {
			return d;
		})
		.style('fill', function (d) {
			return ordinalScale(d);
		});

	var xScale = d3.scaleLinear().domain([0, <%= consultants.Count() %>]).range([0, 1400]);
	var yScale = d3.scaleLinear().domain([<%= maxWon %>, 0]).range([0, 400]);

	var lineGenerator = d3.line()
		.x(function (d, i) {
			return xScale(i);
		})
		.y(function (d) {
			return yScale(d.value);
		});

	//var data = [
	//	{ value: 10 },
	//	{ value: 50 },
	//	{ value: 30 },
	//	{ value: 40 },
	//	{ value: 20 },
	//	{ value: 70 },
	//	{ value: 80 },
	//	{ value: 40 },
	//	{ value: 20 },
	//	{ value: 30 },
	//	{ value: 10 },
	//	{ value: 50 }
	//];
	
	var line = lineGenerator(data);

	// Create a path element and set its d attribute
	d3.select('#road')
		.append('path')
		.attr('d', line);



 //   const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

 //   const formatAxis = d3.format(" 0");
 //   const axis = d3.svg.axis()
 //       .scale(xScale)
 //       .tickFormat(formatAxis)
 //       .ticks(9)
 //       .tickValues([1, 2, 3, 4, 5, 6, 7, 8, 9])
 //       .orient("bottom");

	//const w = 500;
	//const h = 200;

	//const svg = d3.select(".tests")
	//	.append("svg")
	//	.attr("width", w)
	//	.attr("height", h);

	//svg.selectAll("rect")
	//	.data(dataset)
	//	.enter()
	//	.append("rect")
	//	.attr("x", (d, i) => i * 30)
	//	.attr("y", (d, i) => h - 3 * d)
	//	.attr("width", 25)
	//	.attr("height", (d, i) => d * 3)
	//	.attr("fill", "navy");

	//svg.selectAll("text")
	//	.data(dataset)
	//	.enter()
	//	.append("text")
	//	.text((d) => d)
	//	.attr("x", (d, i) => i * 30)
 //       .attr("y", (d, i) => h - (3 * d) - 3)


	//svg.append("text")      // text label for the x axis
 //       .attr("class", "xlabel")
 //       .attr("x", 265)
	//	.attr("y", 240)
	//	.attr("text-anchor", "middle")
	//	.text("Consultants");


 //   let months = ["Jan", "feb", "March", "April"]
 //   let won = [4, 2, 7,8]

 //   d3.select(".tests")
 //       .selectAll("p")
 //       .data(won)
 //       .enter()
 //       .append("p")
 //       .attr("class","testbar")
 //       .style("height", (d) => (d + "px"))


	//const w = 500;
	//const h = 100;

	//const svg = d3.select("body")
	//	.append("svg")
	//	.attr("width", w)
	//	.attr("height", h);

	//svg.selectAll("rect")
	//	.data(dataset)
	//	.enter()
	//	.append("rect")
 //       .attr("x", (d, i) => { i * 30 })
 //                .attr("y", 0)
	//			.attr("width", 25)
	//			.attr("height", 100);
</script>  




   <%-- <svg height="210" width="500">
  <line x1="0" y1="0" x2="200" y2="200" style="stroke:rgb(255,0,0);stroke-width:2" />
   <line x1="200" y1="200" x2="300" y2="100" style="stroke:rgb(0,255,33);stroke-width:2" />
  Sorry, your browser does not support inline SVG.
</svg>--%>







<%--<div class="slds-p-top--medium">
    <div>
        <svg version="1.2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="quiz-graph">
            <defs>
                <pattern id="grid" width="50" height="50" patternUnits="userSpaceOnUse">
                    <path d="M 50 0 L 0 0 0 50" fill="none" stroke="#e5e5e5" stroke-width="1"></path>
                </pattern>
            </defs>
            <rect x="50" width="calc(100% - 50px)" height="300px" fill="url(#grid)" stroke="gray" margin-top="20px !important"></rect>

            <g class="label-title">
                <text x="-160" y="5" transform="rotate(-90)">Participants</text>
            </g>
            <g class="label-title">
                <text x="50%" y="350">Questions</text>
            </g>   
            <g class="x-labels">
                <text x="150" y="320">Q1</text>
                <text x="250" y="320">Q2</text>
                <text x="350" y="320">Q3</text>
                <text x="450" y="320">Q4</text>
                <text x="550" y="320">Q5</text>
                <text x="650" y="320">Q6</text>
                <text x="750" y="320">Complited</text>
            </g>
            <g class="y-labels">
                <text x="42" y="5">300</text>   
                <text x="42" y="55">250</text>
                <text x="42" y="105">200</text>   
                <text x="42" y="155">150</text>
                <text x="42" y="205">100</text>   
                <text x="42" y="255">50</text>
                <text x="42" y="305">0</text>
            </g>
            <linearGradient id="grad" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:rgba(99,224,238,.5);stop-opacity:1"></stop>
                <stop offset="100%" style="stop-color:white;stop-opacity:0"></stop>
            </linearGradient>
            <polyline fill="url(#grad)" stroke="#34becd"  stroke-width="0" points="
            50,300
            51,0
            150,100
            250,80
            350,160
            450,100
            550,100
            650,150
            750,200
            750,300
            "></polyline>

            <polyline fill="none" stroke="#34becd" stroke-width="2" points="
            50,0
            150,100
            250,80
            350,160
            450,100
            550,100
            650,150
            750,200
            "></polyline>
            <g>
                <circle class="quiz-graph-start-dot" cx="50" cy="0" data-value="7.2" r="6"></circle>
                <circle class="quiz-graph-dot" cx="150" cy="100" data-value="8.1" r="6" q-title="Q1" answer-count="200" percent-value="66%"></circle>
                <circle class="quiz-graph-dot" cx="250" cy="80" data-value="7.7" r="6" q-title="Q2" answer-count="220" percent-value="73%"></circle>
                <circle class="quiz-graph-dot" cx="350" cy="160" data-value="6.8" r="6" q-title="Q3" answer-count="140" percent-value="46%"></circle>
                <circle class="quiz-graph-dot" cx="450" cy="100" data-value="6.7" r="6" q-title="Q4" answer-count="200" percent-value="66%"></circle>
                <circle class="quiz-graph-dot" cx="550" cy="100" data-value="6.7" r="6" q-title="Q5" answer-count="200" percent-value="66%"></circle>
                <circle class="quiz-graph-dot" cx="650" cy="150" data-value="6.7" r="6" q-title="Q6" answer-count="150" percent-value="50%"></circle>
                <circle class="quiz-graph-dot" cx="750" cy="200" data-value="6.7" r="6" q-title="Complited Quiz" answer-count="100" percent-value="33%"></circle>
            </g>
        </svg>
    </div>
</div>
<br />
   >

  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3.select("body")
                  .append("svg")
                  .attr("width", w)
                  .attr("height", h);

    svg.selectAll("rect")
       .data(dataset)
       .enter()
       .append("rect")
       .attr("x", (d, i) => i * 30)
       .attr("y", (d, i) => h - 3 * d)
       .attr("width", 25)
       .attr("height", (d, i) => 3 * d)
       .attr("fill", "navy")
       // Add your code below this line



       // Add your code above this line

    svg.selectAll("text")
       .data(dataset)
       .enter()
       .append("text")
       .text((d) => d)
       .attr("x", (d, i) => i * 30)
       .attr("y", (d, i) => h - (3 * d) - 3);

  </script>--%>

</asp:Content>

