﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jquerytest.aspx.cs" Inherits="jquerytest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery.ui.core.js" type="text/javascript"></script>

    <script src="Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function() {
        $("#datepicker").datepicker();
    });
</script>
    
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        
        Date: <asp:TextBox Columns="6"  ID="datepicker" runat="server"/>
    
    </div>
    </form>
</body>
</html>
