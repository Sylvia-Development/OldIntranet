<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AcademyLogin.aspx.cs" Inherits="AcademyLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div align="center"  margin="300px" style="font-size:1.1em">
                                <asp:Login DestinationPageUrl="~/Default5.aspx" runat="server" >
        </asp:Login>

        </div>
    </form>
</body>
</html>
