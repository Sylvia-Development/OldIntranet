<%@ Page Language="C#" AutoEventWireup="true" CodeFile="emailTest.aspx.cs" Inherits="emailTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Test</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:Label runat="server" ID="label"/> 
      
        <asp:Button runat="server" Text="Send Mail" ID="send"  OnCommand="sendMail" />
    
    
    
    </div>
    </form>
</body>
</html>
