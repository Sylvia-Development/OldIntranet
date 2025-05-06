<%@ Page Language="C#" AutoEventWireup="true" CodeFile="client_info_new.aspx.cs" Inherits="client_info_new" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="page.css" rel="stylesheet" type="text/css" />

    



</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="container">

<div id="one_column" >
    <clientInfo:clientInfoControl id="clientInfoSection" runat="server"
      insertReturnPath="section_info.aspx?pSectionId=-1"
      updateReturnPath="client_info_new.aspx" >
    </clientInfo:clientInfoControl>
 </div>
 </div>
    </div>
    </form>
</body>
</html>
