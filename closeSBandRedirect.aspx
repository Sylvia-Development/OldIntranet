<%@ Page Language="C#" AutoEventWireup="true" CodeFile="closeSBandRedirect.aspx.cs" Inherits="closeSBandRedirect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
       
        
        //parent.location.href=<%Response.Write(Page.Request.QueryString["pRedirectUrl"]); %>;    
       // window.parent.Shadowbox.close();
       // top.location = top.location;
        //alert(<%Response.Write(Page.Request.QueryString["pRedirectUrl"]);%>);
        
        parent.window.location.href =  <%Response.Write(Page.Request.QueryString["pRedirectUrl"]);%>; 
    
    </script>
</head>
<body>
  
</body>
</html>
