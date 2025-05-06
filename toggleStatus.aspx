<%@ Page Language="C#" AutoEventWireup="true" CodeFile="toggleStatus.aspx.cs" Inherits="toggleStatus" %>
{
	<%
		string userid;
		
		userid = Request.QueryString["userid"];
		if (userid == "")
			userid = Request.Form["userid"];
		%>
	guid: "<%= userid %>,
<%
		Guid guid = Guid.Parse(userid);
		if (guid != null)
		{
			Consultant user = ConsultantHandler.getConsultant(guid);
			user.toggleState();
			%>
			all: "good"
<%
	}
	else
			{
		%>
				"error": "Guid Parse Failed"
			<%
				}
		%> 
}