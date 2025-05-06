<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sales_validation.aspx.cs" Inherits="sales_validation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title></title>
    <link href="page.css" rel="stylesheet" type="text/css" />
     <link href="Scripts/jquery-ui-1.8.7.custom/css/smoothness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    

    <script src="Scripts/jquery-ui-1.8.7.custom/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
     <script type="text/javascript">

         $(function () {
             $("input[id$='datepicker']").datepicker({ dateFormat: 'dd, MM, yy', showOtherMonths: true, selectOtherMonths: true });

         });
     </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="container">

<div id="one_column" >
     
     <a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.location.reload();parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>
  <div style=" padding-left:20px;">

    <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
               

<h1>Sales Validation</h1>
<asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableUpdate="True" TableName="sections" 
        OnSelecting="validation_info_selecting">
    </asp:LinqDataSource>
              
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="section_id" 
            
            DataSourceID="LinqDataSource1">
        <ItemTemplate>
            <tr >
                        
                <td>
                    <%# Eval("client.job_name") %> - <%# Eval("section_name") %>
                </td>
               
                <td>
                    <%# Eval("decision_date","{0:ddd, d MMM, yyyy}") %>
                </td>
                <td nowrap="nowrap">
                   <%# Eval("quote_value","{0:c}") %>
                </td>
                <td>
                    <%if (Context.User.IsInRole("Director")){ %> 
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                  <%} %> 
                </td>
                
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                                
                                
                                
                                <th id="Th3" runat="server">
                                    &nbsp</th>
                                
                                   <th id="Th1" runat="server">
                                    Decision Date
                                </th>
                                <th id="Th2" runat="server">
                                    Job Value (incl)
                                </th>   
                                 <th id="Th5" runat="server">
                                 &nbsp
                                   </th> 
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr >
                
                <td>
                    <%# Eval("client.job_name") %> - <%# Eval("section_name") %>
                </td>
                
                
                <td>
                   <asp:TextBox  placeholder="Click for Date..." ID="datepicker"  runat="server" Text='<%# Bind("decision_date","{0:ddd, d MMM, yyyy}") %>' />
                </td>
                
                <td>
                    <asp:TextBox  ID="amount" runat="server" 
                        Text='<%# Bind("quote_value") %>' />        
                </td>
                <td nowrap>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
                
            </tr>
        </EditItemTemplate>
        
       
    </asp:ListView>









            </LoggedInTemplate>
            <AnonymousTemplate>
                <p>Not Logged in</p>
            </AnonymousTemplate>
            </asp:LoginView>



     </div>

 </div>
 </div>
    </div>
    </form>
</body>
</html>