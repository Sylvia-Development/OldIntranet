﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="create_user.aspx.cs" Inherits="create_user" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="page.css" rel="stylesheet" type="text/css" />
    <title>Create User</title>
</head>
<body>
    <form id="form1" runat="server">
    <div align=center>
    <br />
<br />
<asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
            ContinueDestinationPageUrl="~/Default.aspx">
    <WizardSteps>
        <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" />
        <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
    </WizardSteps>
</asp:CreateUserWizard>
    
    </div>
    </form>
</body>
</html>
