<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sms_status.aspx.cs" Inherits="sms_status" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   <link href="page.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="container">

<div id="one_column">
    
   
   
   
    <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
  
  <table>
    <tr>
        <td>    
            <%Response.Write(Page.Request.QueryString["pStatus"]); %>
        </td>
                       
    </tr>     
  </table>     
        
        
        
    </LoggedInTemplate>
    <AnonymousTemplate>
    
    
    
    You need to be logged in to use this functionality
    
    </AnonymousTemplate>
    
 </asp:LoginView>
    
    
    
   
   
   
   
   
   
    
    
    
  </div> 
    
    
    </div>
    
    </form>
</body>




</html>